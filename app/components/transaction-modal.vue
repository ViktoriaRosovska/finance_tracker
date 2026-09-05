<template>
  <UModal
    title="Add transaction"
    :close="{
      color: 'neutral',
      variant: 'ghost',
      class: 'rounded-full',
    }"
    @after:leave="resetForm"
    v-model:open="isOpen"
  >
    <template #default>
      <UButton
        icon="i-heroicons-plus-circle"
        color="primary"
        variant="solid"
        label="Add"
      />
    </template>
    <template #body>
      <UForm
        ref="form"
        @submit="onSubmit"
        class="flex flex-col space-y-6"
        :state="state"
        :schema="schema"
        autocomplete="on"
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
            :max="maxDate"
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
        />
      </UForm>
    </template>
  </UModal>
</template>
<script setup lang="ts">
import { schemaAddTransaction as schema } from "~/validation/schemaAddTransaction";

const isOpen = ref(false);
const form = ref();
const today = new Date();
const maxDate = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, "0")}-${String(today.getDate()).padStart(2, "0")}`;
const openDatePicker = (event: MouseEvent) => {
  const input = event.currentTarget as HTMLInputElement;
  input.showPicker();
};
const transactionTypeItems = ref(["income", "expense"]);

const categoriesItems = [
  {
    value: "356fb44b-49e5-4425-9f62-f8835886ae50",
    label: "Savings",
  },
  { value: "388ba354-ab93-4602-b4ff-9ab66c80aa59", label: "Salary" },
  { value: "55406f87-98a8-45e4-8f8b-92505e9d17d9", label: "Transport" },
  { value: "64544fc3-966a-4fda-a376-c1421d1be2ed", label: "Food" },
  { value: "758cef67-7a13-4aaf-b449-e7db66854d88", label: "Shopping" },
];

const onSubmit = () => {
  console.log("Submit form", state);
  isOpen.value = false;
};
const formatDate = (date: Date) => {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");

  return `${year}-${month}-${day}`;
};
const createInitialState = () => ({
  user_id: "2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2",
  type: undefined,
  amount: undefined,
  description: undefined,
  created_at: new Date().toISOString(),
  transaction_date: formatDate(new Date()),
  category_id: undefined,
});

const state = reactive(createInitialState());

const resetForm = () => {
  Object.assign(state, createInitialState());
  form.value.clear();
};
</script>
