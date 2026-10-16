CREATE POLICY "Users can delete their own avatar" ON "storage"."objects"
  FOR DELETE
  TO "authenticated"
  USING (((bucket_id = 'avatars'::text) AND ((storage.foldername(name))[1] = ( SELECT (auth.uid())::text AS uid))));

CREATE POLICY "Users can update their own avatar" ON "storage"."objects"
  FOR UPDATE
  TO "authenticated"
  USING (((bucket_id = 'avatars'::text) AND ((storage.foldername(name))[1] = ( SELECT (auth.uid())::text AS uid))))
  WITH CHECK (((bucket_id = 'avatars'::text) AND ((storage.foldername(name))[1] = ( SELECT (auth.uid())::text AS uid))));

CREATE POLICY "Users can upload their own avatar" ON "storage"."objects"
  FOR INSERT
  TO "authenticated"
  WITH CHECK (((bucket_id = 'avatars'::text) AND ((storage.foldername(name))[1] = ( SELECT (auth.uid())::text AS uid))));

CREATE POLICY "Users can view their own avatar" ON "storage"."objects"
  FOR SELECT
  TO "authenticated"
  USING (((bucket_id = 'avatars'::text) AND ((storage.foldername(name))[1] = ( SELECT (auth.uid())::text AS uid))));
