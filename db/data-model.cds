namespace ecommerce.system;
using { Country, managed } from '@sap/cds/common';

entity Products {
  key ID : Integer;
  title  : localized String;
  customer : Association to Customers;
  stock  : Integer;
}

entity Customers {
  key ID : Integer;
  name   : String;
  products  : Association to many Products on products.customer = $self;
}

entity Orders : managed {
  key ID  : UUID;
  product : Association to Products;
  customer: Association to Customers;
  country : Country;
  amount  : Integer;
}
