module just_memo::counter {

    const MODULE_ADMIN: address = @just_memo;

    #[derive(Debug)]
    struct Counter<phantom X> has key {
        value: u64
    }

    #[derive(Debug)]
    struct Price<phantom X> has key {
        value: u64,
        dec: u8,
    }

    entry fun create_counter<X>(admin: &signer)
    {
        let counter = Counter<X> { value: 0 };
        move_to<Counter<X>>(admin, counter);
    }

    entry fun push_counter<X>(value: u64)
    acquires Counter
    {
        let counter = borrow_global_mut<Counter<X>>(MODULE_ADMIN);
        counter.value = value;
    }

    entry fun create_price<X>(admin: &signer)
    {
        let price = Price<X> { value: 0, dec: 0 };
        move_to(admin, price);
    }

    entry fun push_price<X>(value: u64, dec: u8)
    acquires Price
    {
        let price = borrow_global_mut<Price<X>>(MODULE_ADMIN);
        price.value = value;
        price.dec = dec;
    }
}
