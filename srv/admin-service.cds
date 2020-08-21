using {ecommerce.system as my} from '../db/data-model';

service AdminService @(requires : 'admin') {
  entity Products   as projection on my.Products;
  entity Customers  as projection on my.Customers;
  entity Orders     as select from my.Orders;
  entity OrderItems as select from my.OrderItems;
}

// Restrict access to orders to users with role "admin"
annotate AdminService.Orders with @(restrict : [{
  grant : 'READ',
  to    : 'admin'
}]);

annotate AdminService.OrderItems with @(restrict : [{
  grant : 'READ',
  to    : 'admin'
}]);