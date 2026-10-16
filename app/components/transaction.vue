<template>
  <div
    class="grid grid-cols-3 gap-2 py-4 border-b border-gray-200 dark:border-gray-800 text-gray-900 dark:text-gray-100 font-medium"
  >
    <div class="flex items-center justify-between gap-4 col-span-2">
      <div class="flex items-center space-x-1 min-w-0">
        <UIcon :name="icon" :class="[iconColor]" />
        <div
          class="wrap-break-word sm:max-w-64 md:max-w-100 xl:max-w-160 min-w-0"
        >
          {{ props.transaction.description }}
        </div>
      </div>
      <div class="min-w-0 max-w-100">
        <UBadge
          class="block max-w--full overflow-hidden whitespace-nowrap text-ellipsis"
          color="neutral"
          variant="outline"
          v-if="props.transaction.category"
          >{{ props.transaction.category.name }}</UBadge
        >
      </div>
    </div>
    <div class="flex items-center justify-end space-x-2 w-full">
      <div>
        {{ currency }}
      </div>
      <div>
        <UDropdownMenu
          :items="items"
          :content="{ side: 'bottom', align: 'start' }"
        >
          <UButton
            icon="i-lucide-ellipsis-vertical"
            variant="ghost"
            color="primary"
            :loading="isLoading"
          />
        </UDropdownMenu>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import type { DropdownMenuItem } from "@nuxt/ui";
import type { GetTransaction } from "~/types";

const props = defineProps<{
  transaction: GetTransaction;
}>();
const emit = defineEmits<{
  deleted: [];
  edited: [transaction: GetTransaction];
}>();
const isExpense = computed(() => props.transaction.type === "expense");
const icon = computed(() =>
  isExpense.value
    ? "i-heroicons-arrow-down-left"
    : "i-heroicons-arrow-up-right",
);
const iconColor = computed(() =>
  isExpense.value ? "text-red-600" : "text-green-600",
);

const { currency } = useCurrency(props.transaction.amount);
const isLoading = ref(false);
const toast = useAppToast();
const supabase = useSupabaseClient();

const deleteTransaction = async () => {
  isLoading.value = true;
  try {
    const { error } = await supabase
      .from("transactions")
      .delete()
      .eq("id", props.transaction.id);
    if (error) {
      throw error;
    }
    emit("deleted");

    toast.toastSuccess({ title: "Transaction deleted" });
  } catch (error) {
    console.error("Delete transaction error:", error);

    toast.toastError({
      title: "Failed to delete transaction",
      description: error instanceof Error ? error.message : "Unknown error",
    });
  } finally {
    isLoading.value = false;
  }
};
const items: DropdownMenuItem[][] = [
  [
    {
      label: "Edit",
      icon: "i-heroicons-pencil-square-20-solid",
      onSelect: () => {
        console.log("Edit");
        editTransaction(props.transaction);
      },
    },
    {
      label: "Delete",
      icon: "i-heroicons-trash-20-solid",
      onSelect: () => deleteTransaction(),
    },
  ],
];
const editTransaction = (transaction: GetTransaction) => {
  emit("edited", transaction);
};
</script>
