<template>
  <UForm
    ref="form"
    @submit="submit"
    class="flex flex-col space-y-6"
    :state="state"
    :schema="schema"
    autocomplete="on"
    novalidate
  >
    <UFormField label="Transaction type" required name="type">
      <USelect
        :items="transactionTypeItems"
        v-model="state.type"
        class="w-full"
        placeholder="Select the transaction type"
      />
    </UFormField>
    <UFormField label="Select category" required name="category_id">
      <USelect
        :items="categoriesItems"
        v-model="state.category_id"
        value-key="value"
        label-key="label"
        class="w-full"
        placeholder="Select category"
      />
    </UFormField>
    <UFormField label="Amount" required hint="($)" name="amount">
      <UInput
        v-model.number="state.amount"
        type="number"
        placeholder="Amount"
        name="amount"
        autocomplete="on"
        :min="0"
        class="w-full"
        :ui="{
          base: 'appearance-none [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none',
        }"
      />
    </UFormField>
    <UFormField
      label="Description"
      hint="Optional"
      name="description"
      :required="false"
    >
      <UInput
        v-model="state.description"
        class="w-full"
        name="description"
        placeholder="Description"
        autocomplete="on"
      />
    </UFormField>
    <UFormField label="Transaction date">
      <UInput
        type="date"
        :max="maxDate()"
        trailing-icon="i-heroicons-calendar-days-20-solid"
        class="w-full [&_input::-webkit-calendar-picker-indicator]:opacity-0 [&_input::-webkit-calendar-picker-indicator]:pointer-events-none"
        :ui="{
          base: 'text-gray-800 pr-2.5 cursor-pointer',
          trailingIcon: 'text-black',
          trailing: 'pointer-events-none',
        }"
        ref="datePicker"
        v-model="state.transaction_date"
        @click="openDatePicker"
      />
    </UFormField>
    <UButton
      type="submit"
      class="w-30 flex justify-center m-auto"
      label="Save"
      :loading="isLoading"
      loading-icon="i-heroicons-arrow-path"
    />
  </UForm>
</template>
<script setup lang="ts">
import type { AddTransactionForm, GetTransaction } from "~/types";
import { categoriesItems, transactionTypeItems } from "~/constants";
import { schemaAddTransaction as schema } from "~/validation/schemaAddTransaction";
import { formatDate } from "~/helpers/formatDate";
import { maxDate } from "~/helpers/maxDate";

const props = defineProps<{
  transaction: GetTransaction | null;
  isEditing: boolean;
  isLoading: boolean;
}>();

const emit = defineEmits<{
  (e: "submit", payload: AddTransactionForm): void;
}>();
const form = ref();
const createInitialState = (): AddTransactionForm => ({
  type: undefined,
  amount: undefined,
  description: undefined,
  created_at: new Date().toISOString(),
  transaction_date: formatDate(new Date()),
  category_id: undefined,
});

const state = reactive<AddTransactionForm>(createInitialState());

watch(
  () => props.transaction,
  (transaction) => {
    if (transaction) {
      Object.assign(state, {
        type: transaction.type,
        amount: transaction.amount,
        description: transaction.description ?? undefined,
        created_at: transaction.created_at,
        transaction_date: transaction.transaction_date,
        category_id: categoriesItems.find(
          (category) => category.label === transaction.category?.name,
        )?.value,
      });
    } else {
      Object.assign(state, createInitialState());
    }
  },
  { immediate: true },
);
const submit = () => {
  emit("submit", { ...state });
};

const openDatePicker = (event: MouseEvent) => {
  const input = event.currentTarget as HTMLInputElement;
  input.showPicker();
};

const resetForm = () => {
  Object.assign(state, createInitialState());
  form.value?.clear();
};

defineExpose({
  resetForm,
});
</script>
