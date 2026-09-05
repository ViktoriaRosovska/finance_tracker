<template>
  <div
    class="grid grid-cols-2 py-4 border-b border-gray-200 dark:border-gray-800 text-gray-900 dark:text-gray-100 font-medium"
  >
    <div class="flex items-center justify-between">
      <div class="flex items-center space-x-1">
        <UIcon :name="icon" :class="[iconColor]" />
        <div>{{ props.transaction.description }}</div>
      </div>
      <div>
        <UBadge
          color="neutral"
          variant="outline"
          v-if="props.transaction.category"
          >{{ props.transaction.category.name }}</UBadge
        >
      </div>
    </div>
    <div class="flex items-center justify-end space-x-2">
      <div>{{ currency }}</div>
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
import type { Transaction } from "~/types";

const props = defineProps<{
  transaction: Transaction;
}>();
const emit = defineEmits<{
  deleted: [];
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

// console.log(props.transaction);
const { currency } = useCurrency(props.transaction.amount);
const isLoading = ref(false);
const toast = useToast();
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
    console.log("DELETE SUCCESS");
    emit("deleted");
    toast.add({
      title: "Transaction deleted",
      icon: "i-heroicons-check-circle",
      color: "success",
    });
  } catch (error) {
    console.error("Delete transaction error:", error);
    toast.add({
      title: "Failed to delete transaction",
      description: error instanceof Error ? error.message : "Unknown error",
      icon: "i-heroicons-exclamation-circle",
      color: "error",
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
      onSelect: () => console.log("Edit"),
    },
    {
      label: "Delete",
      icon: "i-heroicons-trash-20-solid",
      onSelect: () => deleteTransaction(),
    },
  ],
];
</script>
