defmodule BRAN.Banks.NubankTest do
  alias BRAN.Banks.Nubank

  use ExUnit.Case
  use ExUnit.Parameterized

  describe "BRAN.Banks.NubankTest" do
    test_with_params "should return valid tuple when the account is valid",
                     fn agency, account, digit ->
                       assert Nubank.validate(agency, account, digit) == {:ok, :valid}
                     end do
      [
        {[0, 0, 0, 1], [5, 2, 1, 6, 1, 2, 5], 0},
        {[0, 0, 0, 1], [1, 6, 9, 9, 6, 2, 9], 9},
        {[0, 0, 0, 1], [3, 8, 9, 4, 0, 6, 6], 5},
        {[0, 0, 0, 1], [9, 6, 8, 0, 5, 2, 0, 3], 6},
        {[0, 0, 0, 1], [1, 4, 1, 7, 8], 3},
        {[0, 0, 0, 1], [1, 0, 4, 4, 8, 9, 5], 0},
        {[0, 0, 0, 1], [1, 1, 0, 8, 6, 7, 8], 9},
        {[0, 0, 0, 1], [1, 1, 2, 9, 8, 6, 7], 8},
        {[0, 0, 0, 1], [1, 1, 3, 7, 5, 0, 1], 8},
        {[0, 0, 0, 1], [1, 1, 3, 7, 8, 4, 3], 5},
        {[0, 0, 0, 1], [1, 2, 2, 0, 2, 4, 6], 1},
        {[0, 0, 0, 1], [1, 2, 2, 6, 0, 0, 8], 0},
        {[0, 0, 0, 1], [1, 2, 4, 6, 5, 0, 6], 1},
        {[0, 0, 0, 1], [1, 3, 5, 3, 7, 7, 2], 8},
        {[0, 0, 0, 1], [1, 3, 6, 1, 2, 9, 7], 2},
        {[0, 0, 0, 1], [1, 5, 0, 4, 1, 9, 7], 6},
        {[0, 0, 0, 1], [1, 5, 3, 5, 6, 7, 7], 7},
        {[0, 0, 0, 1], [1, 5, 8, 3, 1, 1, 4], 1},
        {[0, 0, 0, 1], [1, 6, 0, 9, 5, 5, 3], 6},
        {[0, 0, 0, 1], [1, 0, 3, 8, 1, 6, 5, 2], 9},
        {[0, 0, 0, 1], [1, 1, 4, 4, 7, 2, 2, 4], 8},
        {[0, 0, 0, 1], [1, 1, 5, 3, 7, 3, 1, 0], 4},
        {[0, 0, 0, 1], [1, 3, 6, 2, 9, 8, 1, 2], 8},
        {[0, 0, 0, 1], [1, 3, 9, 7, 7, 1, 8, 8], 0},
        {[0, 0, 0, 1], [1, 4, 7, 6, 4, 2, 0, 0], 1},
        {[0, 0, 0, 1], [1, 5, 0, 5, 4, 3, 3, 6], 2},
        {[0, 0, 0, 1], [1, 5, 1, 9, 2, 6, 9, 5], 9},
        {[0, 0, 0, 1], [1, 5, 5, 0, 1, 9, 3, 9], 9},
        {[0, 0, 0, 1], [1, 5, 5, 7, 9, 7, 5, 0], 7},
        {[0, 0, 0, 1], [1, 5, 6, 9, 7, 9, 7, 0], 6},
        {[0, 0, 0, 1], [1, 5, 6, 9, 9, 8, 7, 4], 5},
        {[0, 0, 0, 1], [1, 5, 8, 3, 5, 2, 7, 4], 9},
        {[0, 0, 0, 1], [1, 6, 0, 5, 8, 0, 4, 7], 0},
        {[0, 0, 0, 1], [0, 0, 0, 7, 6, 8, 3, 2, 0, 6, 0], 9}
      ]
    end

    test_with_params "should return :invalid_agency_code tuple when the agency is not valid",
                     fn agency, account, digit ->
                       assert Nubank.validate(agency, account, digit) ==
                                {:error, :invalid_agency_code}
                     end do
      [
        {[1, 0, 0, 1], [5, 2, 1, 6, 1, 2, 5], 0},
        {[0, 1, 0, 1], [1, 6, 9, 9, 6, 2, 9], 9},
        {[0, 0, 1, 1], [3, 8, 9, 4, 0, 6, 6], 5}
      ]
    end

    test_with_params "should return :not_valid tuple when the account is not valid",
                     fn agency, account, digit ->
                       assert Nubank.validate(agency, account, digit) == {:error, :not_valid}
                     end do
      [
        {[0, 0, 0, 1], [5, 2, 1, 6, 1, 2, 5], 1},
        {[0, 0, 0, 1], [1, 6, 9, 9, 6, 2, 9], 0},
        {[0, 0, 0, 1], [3, 8, 9, 4, 0, 6, 6], 4},
        {[0, 0, 0, 1], [9, 6, 8, 0, 5, 2, 0, 3], 3}
      ]
    end
  end
end
