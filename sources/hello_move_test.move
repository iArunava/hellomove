#[test_only]
module hello_move::message_tests {
    use std::signer;
    use std::unit_test;
    use std::vector;
    use std::string;

    use hello_move::message;

    fun get_account(): signer {
        vector::pop_back(&mut unit_test::create_signers_for_testing(1))
    }

    #[test]
    public entry fun sender_can_set_message() {
        let account = get_account();
        let addr = signer::address_of(&account);
        let stra = string::utf8(b"Hello, Blockchain");
        aptos_framework::account::create_account_for_test(addr);
        message::set_message(account, stra);
        let receivedmsg = message::get_message(addr);

        assert!(
          receivedmsg == stra,
          0);
    }
}
