using ecommerce.system as my from '../db/data-model';

service CatalogService @(_requires:'authenticated-user') {
    entity Products as projection on my.Products;
    entity Customers as projection on my.Customers;
    entity Orders as select from my.Orders;
}

// Temporary workaround -> https://github.wdf.sap.corp/cap/issues/issues/3121
// extend service CatalogService with {
//   entity OrderItems as select from my.OrderItems;
// }
// Restrict access to orders to users with role "admin"
 annotate CatalogService.Orders with  @(restrict: [
   { grant: 'READ', to: 'admin' } 
  ]);