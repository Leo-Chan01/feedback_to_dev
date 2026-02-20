// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts";

// console.log("Hello from Functions!")

// Deno.serve(async (req) => {
//   const { name } = await req.json()
//   const data = {
//     message: `Hello ${name}!`,
//   }

//   return new Response(
//     JSON.stringify(data),
//     { headers: { "Content-Type": "application/json" } },
//   )
// })

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/access-login' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

Deno.serve(async (req) => {
  try {
    const { access_id } = await req.json();

    if (!access_id) {
      return new Response(
        JSON.stringify({ error: "access_id required" }),
        { status: 400 },
      );
    }

    const supabaseAdmin = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
    );

    // 🔐 lookup your internal user table
    const { data: user, error: userError } = await supabaseAdmin
      .from("users")
      .select("*")
      .eq("access_id", access_id)
      .single();

    if (userError || !user) {
      return new Response(
        JSON.stringify({ error: "Invalid access_id" }),
        { status: 401 },
      );
    }

    // 🔑 Generate Magic Link to get a temporary token/OTP
    const { data: linkData, error: linkError } = await supabaseAdmin.auth.admin
      .generateLink({
        type: "magiclink",
        email: user.email,
      });

    if (linkError || !linkData) {
      return new Response(
        JSON.stringify({
          error: "Failed to generate login link",
          details: linkError,
        }),
        { status: 500 },
      );
    }

    // 🔑 Verify the OTP (from the magic link hash) to get a real session
    const { data: sessionData, error: sessionError } = await supabaseAdmin.auth
      .verifyOtp({
        token_hash: linkData.properties.hashed_token,
        type: "magiclink",
      });

    if (sessionError || !sessionData) {
      return new Response(
        JSON.stringify({
          error: "Failed to verify login",
          details: sessionError,
        }),
        { status: 500 },
      );
    }

    return new Response(
      JSON.stringify({
        session: sessionData.session,
        user: user,
      }),
      {
        status: 200,
        headers: { "Content-Type": "application/json" },
      },
    );
  } catch (e) {
    const message = e instanceof Error ? e.message : String(e);

    return new Response(
      JSON.stringify({ error: message }),
      {
        status: 500,
        headers: { "Content-Type": "application/json" },
      },
    );
  }
});
