import type { UpdateUser } from "~/types";

export const useAuth = () => {
  const supabase = useSupabaseClient();

  const user = useSupabaseUser();
  const { getPublicAvatarUrl } = useBucket();

  const userSignIn = async (email: string) => {
    const { data, error } = await supabase.auth.signInWithOtp({
      email,
      options: {
        emailRedirectTo: "http://localhost:3000/confirm",
      },
    });

    if (error) {
      throw error;
    }
    return { data, error };
  };

  const getUser = async () => {
    const { data, error } = await supabase.auth.getUser();

    if (error) {
      console.error(error);
      user.value = null;
      return null;
    }

    return data.user;
  };

  const logout = async () => {
    const { error } = await supabase.auth.signOut();

    if (error) {
      throw error;
    }
    user.value = null;
  };

  const redirectIfAuthenticate = (fallbackUrl: string = "/") => {
    const redirectInfo = useSupabaseCookieRedirect();

    watch(
      user,
      async (newUser) => {
        if (!newUser) return;

        const path = redirectInfo.pluck();

        await navigateTo(path || fallbackUrl);
      },
      { immediate: true },
    );
  };

  const updateUser = async (userData: UpdateUser) => {
    const { error } = await supabase.auth.updateUser(userData);
    if (error) {
      throw error;
    }
    const { data: sessionData, error: sessionError } =
      await supabase.auth.refreshSession();

    if (sessionError) {
      throw sessionError;
    }
    return sessionData.user;
  };

  const avatarVersion = useState("avatar-version", () => 0);

  const avatarUrl = computed(() => {
    const path = user.value?.user_metadata?.avatar_url;

    if (!path) {
      return "/images/avatar.svg";
    }

    return `${getPublicAvatarUrl(path)}`;
  });
  const refreshAvatar = () => {
    avatarVersion.value++;
  };
  return {
    user,
    userSignIn,
    getUser,
    updateUser,
    logout,
    redirectIfAuthenticate,
    refreshAvatar,
    avatarUrl,
  };
};
