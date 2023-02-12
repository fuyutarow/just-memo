module just_memo::counter {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    const MODULE_ADMIN: address = @just_memo;

    #[derive(Debug)]
    struct Counter<phantom X> has key {
        id: UID,
        value: u64,
    }

    #[derive(Debug)]
    struct Price<phantom X> has key {
        id: UID,
        value: u64,
        dec: u8,
    }

    entry fun create_counter<X>(ctx: &mut TxContext) {
        let counter = Counter<X> {
            id: object::new(ctx),
            value: 0
        };
        transfer::transfer(counter, tx_context::sender(ctx))
    }

    entry fun push_counter<X>(counter: &mut Counter<X>, value: u64) {
        counter.value = value;
    }

    entry fun create_price<X>(ctx: &mut TxContext) {
        let price = Price<X> {
            id: object::new(ctx),
            value: 0,
            dec: 0,
        };
        transfer::transfer(price, tx_context::sender(ctx))
    }

    entry fun push_price<X>(price: &mut Price<X>, value: u64, dec: u8) {
        price.value = value;
        price.dec = dec;
    }

}
