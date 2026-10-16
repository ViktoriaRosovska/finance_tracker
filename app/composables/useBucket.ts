export const useBucket = () => {
  const supabase = useSupabaseClient();

  const deleteAvatar = async (path: string) => {
    const { error } = await supabase.storage.from("avatars").remove([path]);

    if (error) {
      throw error;
    }
  };
  const uploadAvatar = async (path: string, file: File) => {
    const { data, error } = await supabase.storage
      .from("avatars")
      .upload(path, file, { contentType: file.type });

    if (error) {
      throw error;
    }
    return data;
  };

  const getPublicAvatarUrl = (path: string) => {
    const { data } = supabase.storage.from("avatars").getPublicUrl(path);
    return data.publicUrl;
  };
  return {
    uploadAvatar,
    deleteAvatar,
    getPublicAvatarUrl,
  };
};
