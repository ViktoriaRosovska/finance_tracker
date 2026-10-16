CREATE POLICY "Allow authenticated to read categories" ON "public"."categories"
  FOR SELECT
  TO "authenticated"
  USING (true);

REVOKE ALL ON TABLE "public"."categories" FROM "authenticated";

GRANT SELECT ON TABLE "public"."categories" TO "authenticated";

REVOKE ALL ON TABLE "public"."transactions" FROM "authenticated";

GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE "public"."transactions" TO "authenticated";
