<template>
  <UForm
    :state="state"
    :schema="schemaSettings"
    @submit="saveSettings"
    class="space-x-4"
  >
    <UFormField
      name="transactionView"
      label="Transaction View"
      help="Choose how you would to view transactions"
    >
      <USelect
        v-model="state.transactionView"
        :items="transactionViewOptions"
        class="w-full"
      />
    </UFormField>
    <UButton
      label="Save"
      type="submit"
      :loading="isLoading"
      :disabled="isLoading"
    />
  </UForm>
</template>
<script setup lang="ts">
import type { AuthError } from "@supabase/supabase-js";
import { schemaSettings } from "~/validation/schemaSettings";
import { transactionViewOptions } from "~/constants";

const { user, updateUser } = useAuth();
console.log(user.value);
const toast = useAppToast();
const isLoading = ref(false);
const state = reactive({
  transactionView:
    user.value?.user_metadata?.transaction_view ?? transactionViewOptions[0],
});
const saveSettings = async () => {
  isLoading.value = true;
  try {
    await updateUser({
      data: {
        transaction_view: state.transactionView,
      },
    });
    toast.toastSuccess({
      title: "Settings updated",
    });
  } catch (error) {
    const authError = error as AuthError;
    toast.toastError({
      title: "Error updating settings",
      description: authError.message,
    });
  } finally {
    isLoading.value = false;
  }
};
</script>
