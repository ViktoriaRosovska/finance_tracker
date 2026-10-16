<template>
  <UModal
    :open="props.open"
    :title="isEditing ? 'Edit transaction' : 'Add transaction'"
    :close="{
      color: 'neutral',
      variant: 'ghost',
      class: 'rounded-full',
    }"
    @update:open="emit('update:open', $event)"
    @after:leave="transactionForm?.resetForm()"
  >
    <template #body>
      <TransactionForm
        :transaction="transaction"
        :is-editing="isEditing"
        :is-loading="isLoading"
        @submit="onSubmit"
      />
    </template>
  </UModal>
</template>
<script setup lang="ts">
import type { AddTransactionForm, GetTransaction } from "~/types";

const emit = defineEmits<{
  (e: "savedTransaction"): void;
  (e: "update:open", value: boolean): void;
}>();
const props = defineProps<{
  open: boolean;
  transaction: GetTransaction | null;
}>();

const isEditing = computed(() => !!props.transaction);

// type TransactionInsert = Database["public"]["Tables"]["transactions"]["Insert"];
// type TransactionForm = Partial<TransactionInsert>;

const { getUser } = useAuth();
const { addTransaction, editTransaction } = useFetchTransactions();
const toast = useAppToast();

const isLoading = ref(false);

const onSubmit = async (payload: AddTransactionForm) => {
  const currentUser = await getUser();
  if (!currentUser) {
    toast.toastError({
      title: "Not authenticated",
      description: "Something wrong with user's authenticate.",
    });
    return;
  }

  // console.log({
  //   user_id: currentUser.id,
  //   amount: payload.amount,
  //   type: payload.type,
  //   category_id: payload.category_id,
  //   description: payload.description,
  //   created_at: payload.created_at,
  //   transaction_date: payload.transaction_date,
  // });

  try {
    isLoading.value = true;

    if (
      payload.amount === undefined ||
      payload.type === undefined ||
      payload.category_id === undefined
    ) {
      toast.toastError({
        title: "Fill in all required fields",
        description: "Empty fields",
      });
      return;
    }
    const transaction = {
      user_id: currentUser.id,
      amount: payload.amount,
      type: payload.type,
      category_id: payload.category_id,
      description: payload.description,
      created_at: payload.created_at,
      transaction_date: payload.transaction_date,
    };

    if (isEditing.value && props.transaction) {
      await editTransaction(props.transaction?.id, transaction);
      toast.toastSuccess({ title: "Transaction was edited" });
    } else {
      await addTransaction(transaction);
      toast.toastSuccess({ title: "Transaction saved" });
    }
    emit("savedTransaction");
    emit("update:open", false);
  } catch (error) {
    toast.toastError({
      title: "Transaction not saved",
      description:
        error instanceof Error
          ? error.message
          : "Network error. Check your interner connection",
    });
  } finally {
    isLoading.value = false;
  }
};

const transactionForm = ref<{
  resetForm: () => void;
} | null>(null);
</script>
