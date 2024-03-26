import ICRC2 "../services/ICRC2";
import Time "mo:base/Time";
import Nat64 "mo:base/Nat64";

actor class Treasury() = this {

  private type Account = ICRC2.Account;
  private type TransferArg = ICRC2.TransferArg;
  private type TransferFromArgs = ICRC2.TransferFromArgs;
  private type ApproveArgs = ICRC2.ApproveArgs;
  private type AllowanceArgs = ICRC2.AllowanceArgs;
  private type TransferResult = ICRC2.TransferResult;
  private type TransferFromResult = ICRC2.TransferFromResult;
  private type ApproveResult = ICRC2.ApproveResult;
  private type Allowance = ICRC2.Allowance;

  private func _transfer(arg : TransferArg, token : Text) : async TransferResult {
    let service = ICRC2.service(token);
    await service.icrc1_transfer(arg);
  };

  private func _transferFrom(arg : TransferFromArgs, token : Text) : async TransferFromResult {
    let service = ICRC2.service(token);
    await service.icrc2_transfer_from(arg);
  };

  private func _approve(arg : ApproveArgs, token : Text) : async ApproveResult {
    let service = ICRC2.service(token);
    await service.icrc2_approve(arg);
  };

  private func _allowance(arg : AllowanceArgs, token : Text) : async Allowance {
    let service = ICRC2.service(token);
    await service.icrc2_allowance(arg);
  };

  private func _createTransferArg(to : Account, fee : ?Nat, memo : ?Blob, amount : Nat, from_subaccount : ?Blob) : TransferArg {
    let now = Time.now();
    {
      to = to;
      fee = fee;
      memo = memo;
      from_subaccount = from_subaccount;
      created_at_time = ?Nat64.fromIntWrap(now);
      amount = amount;
    };
  };

  private func _createTransferFromArg(from : Account, to : Account, fee : ?Nat, memo : ?Blob, amount : Nat, spender_subaccount : ?Blob) : TransferFromArgs {
    let now = Time.now();
    {
      spender_subaccount = spender_subaccount;
      from = from;
      to = to;
      amount = amount;
      fee = fee;
      memo = memo;
      created_at_time = ?Nat64.fromIntWrap(now);
    };
  };

  private func _createApproveArg(spender : Account, amount : Nat, fee : ?Nat, memo : ?Blob, expected_allowance : ?Nat, expires_at : ?Nat64, from_subaccount : ?Blob) : ApproveArgs {
    let now = Time.now();
    {
      fee = fee;
      memo = memo;
      from_subaccount = from_subaccount;
      created_at_time = ?Nat64.fromIntWrap(now);
      amount = amount;
      expected_allowance = expected_allowance;
      expires_at = expires_at;
      spender = spender;
    };
  };

  private func _createAllowanceArg(account : Account, spender : Account) : AllowanceArgs {
    {
      account = account;
      spender = spender;
    };
  };
};
