namespace ecommerce.system;
using {
    Currency,
    managed,
    cuid
} from '@sap/cds/common';

type Status : String enum {
    completed;
    processing;
    blocked;
}

entity Products : managed {
    key ID          : Integer;
        productName : String(111);
        descr       : String(1111);
        stock       : Integer;
        price       : Decimal(9, 2);
        currency    : Currency;
}

entity Customers : managed {
    key ID           : Integer;
        customerName : String(30);
        email        : String(50);
        phoneNo      : Integer;
        address      : String(500)
}

entity Orders : cuid, managed {
    orderNo  : String       @title : 'Order Number'; //> readable key
    customer : Association to Customers;
    status   : Status default 'processing';
    items    : Composition of many OrderItems
                   on items.parent = $self;
    total    : Decimal(9, 2)@readonly;
    currency : Currency;
}

entity OrderItems : cuid {
    parent    : Association to Orders;
    product   : Association to Products;
    amount    : Integer;
    netAmount : Decimal(9, 2);
}