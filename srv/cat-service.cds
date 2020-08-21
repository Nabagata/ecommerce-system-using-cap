using {ecommerce.system as my} from '../db/data-model';
using {EPM_REF_APPS_PROD_MAN_SRV as epm} from './external/EPM_REF_APPS_PROD_MAN_SRV.csn';

@path : '/browse'
service CatalogService {

  @readonly
  entity Products         as
    select from my.Products {
      *
    }
    excluding {
      createdBy,
      modifiedBy
    };

  @readonly
  entity ExternalProducts as projection on epm.Products {
    key Id as Product_ID, Name, Description, Price
  };

  
  entity Orders           as projection on my.Orders;

  @readonly
  entity MyOrders         as projection on my.Orders;

}

annotate CatalogService.MyOrders with @(restrict : [{
  grant : 'READ',
  where : 'createdBy = $user'
}]);

annotate CatalogService.Orders with @(restrict : [{
  grant : 'READ',
  where : 'currency_code = $user.currency'
}]);