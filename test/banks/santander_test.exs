defmodule BRAN.Banks.SantanderTest do
  alias BRAN.Banks.Santander

  use ExUnit.Case
  use ExUnit.Parameterized

  doctest BRAN.Banks.Santander

  describe "BRAN.Banks.SantanderTest" do
    test_with_params "should return valid tuple when the account is valid",
                     fn branch, account, digit ->
                       assert Santander.validate(branch, account, digit) == {:ok, :valid}
                     end do
      [
        {[0, 0, 9, 2], [4, 6, 5, 3, 5, 4, 9, 5], 0},
        {[0, 3, 7, 8], [4, 3, 8, 9, 1, 1, 3, 2], 1},
        {[1, 0, 7, 4], [0, 7, 4, 7, 3, 2, 3, 6], 2},
        {[4, 7, 7, 4], [1, 3, 7, 0, 2, 7, 0, 5], 3},
        {[4, 6, 4, 1], [4, 3, 9, 9, 8, 5, 1, 4], 4},
        {[1, 7, 8, 0], [3, 7, 3, 9, 4, 3, 0, 2], 5},
        {[0, 1, 2, 2], [3, 7, 6, 2, 1, 0, 9, 9], 6},
        {[0, 3, 9, 1], [0, 7, 5, 9, 7, 9, 8, 3], 7},
        {[4, 5, 0, 2], [0, 2, 5, 8, 8, 0, 1, 7], 8},
        {[0, 6, 6, 0], [2, 7, 2, 3, 5, 5, 2, 3], 9},
        {[0, 0, 9, 2], [4, 6, 5, 3, 5, 4, 9, 5], "0"},
        {[0, 3, 7, 8], [4, 3, 8, 9, 1, 1, 3, 2], "1"},
        {[1, 0, 7, 4], [0, 7, 4, 7, 3, 2, 3, 6], "2"},
        {[4, 7, 7, 4], [1, 3, 7, 0, 2, 7, 0, 5], "3"},
        {[4, 6, 4, 1], [4, 3, 9, 9, 8, 5, 1, 4], "4"},
        {[1, 7, 8, 0], [3, 7, 3, 9, 4, 3, 0, 2], "5"},
        {[0, 1, 2, 2], [3, 7, 6, 2, 1, 0, 9, 9], "6"},
        {[0, 3, 9, 1], [0, 7, 5, 9, 7, 9, 8, 3], "7"},
        {[4, 5, 0, 2], [0, 2, 5, 8, 8, 0, 1, 7], "8"},
        {[0, 6, 6, 0], [2, 7, 2, 3, 5, 5, 2, 3], "9"}
      ]
    end

    test("should return not_valid tuple when the account is invalid") do
      assert Santander.validate([0, 0, 6, 0], [0, 1, 0, 9, 8, 4, 8, 6], 1) == {:error, :not_valid}
    end

    test(
      "should return invalid_bank_branch_length tuple when the branch number have less than 4 digits"
    ) do
      assert Santander.validate([2, 5, 4], [0, 1, 0, 9, 8, 4, 8, 6], 1) ==
               {:error, :invalid_bank_branch_length}
    end

    test(
      "should return invalid_bank_branch_length tuple when the branch number have more than 4 digits"
    ) do
      assert Santander.validate([0, 0, 6, 0, 5], [0, 1, 0, 9, 8, 4, 8, 6], 1) ==
               {:error, :invalid_bank_branch_length}
    end

    test(
      "should return invalid_account_number_length tuple when the account number have less than 5 digits"
    ) do
      assert Santander.validate([0, 2, 5, 4], [0, 2, 3, 6], 1) ==
               {:error, :invalid_account_number_length}
    end

    test(
      "should return invalid_account_number_length tuple when the account number have more than 6 digits"
    ) do
      assert Santander.validate([0, 0, 6, 0], [0, 1, 0, 9, 8, 4, 8, 6, 6], 0) ==
               {:error, :invalid_account_number_length}
    end

    test(
      "should return invalid_account_type tuple when the account number starts with invalid operation"
    ) do
      assert Santander.validate([0, 0, 6, 0], [9, 9, 0, 9, 8, 4, 8, 6], 0) ==
               {:error, :invalid_account_type}
    end

    test("should return :invalid_account_type tuple when the digit is a character") do
      assert Santander.validate([0, 0, 6, 0], [9, 9, 0, 9, 8, 4, 8, 6], "P") ==
               {:error, :invalid_account_type}
    end
  end
end
