using ecommerce.system as my from '../db/data-model';

service CatalogService {
    entity Products @readonly as projection on my.Products;
    entity Customers @readonly as projection on my.Customers;
    entity Orders @insertonly as projection on my.Orders;
}