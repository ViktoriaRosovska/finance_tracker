<template>
  <UForm :state="state" class="space-y-6" @submit="saveAvatar">
    <div class="w-full flex flex-col gap-4">
      <label class="text-xl font-medium">Current Avatar</label>
      <div class="relative">
        <UAvatar class="rounded-full size-44" :src="avatarUrl" />
        <UButton
          icon="i-heroicons-trash"
          class="absolute top-0 right-0 cursor-pointer"
          variant="soft"
          color="error"
          @click="deleteUserAvatar"
        />
      </div>
    </div>
    <UFormField
      name="fileInput"
      label="New Avatar"
      help="After choosing an image click Save to actually upload the new avatar"
      class="text-xl font-light"
    >
      <div class="avatar-file-upload mt-4">
        <UFileUpload
          accept="image/jpeg;image/jpg;image/webp;image/png;image/gif"
          ref="fileUpload"
          v-model="fileInput"
          position="inside"
          layout="list"
          class="cursor-pointer"
          label="Drop your image here"
          description="JPEG, JPG, WEBP, PNG or GIF (max. 5MB)"
          icon="i-heroicons-camera"
          :ui="{
            base: 'min-h-48',
            avatar: 'size-14 bg-transparent',
          }"
        />
      </div>
    </UFormField>

    <UButton
      type="submit"
      label="Save"
      :loading="uploading"
      :disabled="uploading"
    />
  </UForm>
</template>
<script setup lang="ts">
import type { AuthError } from "@supabase/supabase-js";
const { uploadAvatar, deleteAvatar } = useBucket();
const { user, updateUser, avatarUrl, refreshAvatar } = useAuth();
const state = reactive({});
const toast = useAppToast();

const uploading = ref(false);
const fileInput = ref<File | null>(null);
const avatarPath = ref(user.value?.user_metadata?.avatar_url ?? "");

const saveAvatar = async () => {
  if (!fileInput.value) {
    toast.toastError({
      title: "No file selected",
      description: "Please select a file to upload first.",
    });
    return;
  }
  const oldAvatarPath = user.value?.user_metadata?.avatar_url;
  if (oldAvatarPath) {
    await deleteAvatar(oldAvatarPath);
  }
  const fileExtension = fileInput.value.name.split(".").pop();

  const fileName = `${Math.random()}.${fileExtension}`;
  const newAvatarPath = `${user.value?.sub}/${fileName}`;

  try {
    uploading.value = true;

    // const currentAvatarUrl = user.value?.user_metadata?.avatar_url;
    const data = await uploadAvatar(newAvatarPath, fileInput.value);
    console.log(fileInput.value);
    const updatedUser = await updateUser({
      data: {
        avatar_url: `${data.path}`,
      },
    });

    refreshAvatar();
    avatarPath.value = updatedUser?.user_metadata.avatar_url ?? "";
    fileInput.value = null;

    toast.toastSuccess({
      title: "Avatar was upload",
    });
  } catch (error) {
    const authError = error as AuthError;
    toast.toastError({
      title: "Error with upload avatar",
      description: authError.message,
    });
  } finally {
    uploading.value = false;
  }
};
const deleting = ref(false);
const deleteUserAvatar = async () => {
  const avatarPath = user.value?.user_metadata?.avatar_url;
  if (!avatarPath) {
    toast.toastInfo({
      title: "No avatar to delete",
    });
    return;
  }
  try {
    deleting.value = true;
    await deleteAvatar(avatarPath);
    await updateUser({
      data: {
        avatar_url: null,
      },
    });
    refreshAvatar();
    toast.toastSuccess({
      title: "Avatar deleted",
    });
  } catch (error) {
    const authError = error as AuthError;
    toast.toastError({
      title: "Error deliting avatar",
      description: authError.message,
    });
  } finally {
    deleting.value = false;
  }
};
</script>
<style scoped>
@reference "~/assets/css/main.css";
.avatar-file-upload :deep([data-slot="icon"]) {
  width: 44px !important;
  height: 44px !important;
  @apply text-green-500;
}
</style>
