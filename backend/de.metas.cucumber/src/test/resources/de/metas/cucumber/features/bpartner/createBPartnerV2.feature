Feature: create or update BPartner v2
  As a user
  I want create or update a BPartner record

  Background:
    Given the existing user with login 'metasfresh' receives a random a API token for the existing role with name 'WebUI'

  Scenario: create a BPartner record
    When a 'PUT' request with the below payload is sent to the metasfresh REST-API 'api/v2-pre/bpartner/001' and fulfills with '201' status code
    """
{
   "requestItems":[
      {
         "bpartnerIdentifier":"ext-ALBERTA-001",
         "bpartnerComposite":{
            "bpartner":{
               "code":"test_code",
               "name":"test_name",
               "companyName":"test_company",
               "parentId":null,
               "phone":null,
               "language":"de",
               "url":null,
               "group":"test-group",
               "vatId":null
            },
            "locations":{
               "requestItems":[
                  {
                     "locationIdentifier":"gln-l11",
                     "location":{
                        "address1":"test_address1",
                        "address2":"test_address2",
                        "poBox":null,
                        "district":null,
                        "region":null,
                        "city":null,
                        "countryCode":"DE",
                        "gln":null,
                        "postal":null
                     }
                  },
                  {
                     "locationIdentifier":"gln-l22",
                     "location":{
                        "address1":null,
                        "address2":"test_address2",
                        "poBox":"test_poBox",
                        "district":null,
                        "region":"test_region",
                        "city":"test_city",
                        "countryCode":"DE",
                        "gln":null,
                        "postal":null
                     }
                  }
               ]
            },
            "contacts":{
               "requestItems":[
                  {
                     "contactIdentifier":"ext-ALBERTA-c11",
                     "contact":{
                        "code":"c11",
                        "name":"test_name_c11",
                        "email":"test_email",
                        "fax":"fax"
                     }
                  },
                  {
                     "contactIdentifier":"ext-ALBERTA-c22",
                     "contact":{
                        "code":"c22",
                        "name":"test_name_c22",
                        "email":null,
                        "fax":"test_fax"
                     }
                  }
               ]
            }
         }
      }
   ],
   "syncAdvise":{
      "ifNotExists":"CREATE",
      "ifExists":"UPDATE_MERGE"
   }
}
"""
    Then verify that bPartner was created for externalIdentifier
      | externalIdentifier | OPT.Code  | Name      | OPT.CompanyName | OPT.ParentId | OPT.Phone | OPT.Language | OPT.Url | OPT.Group  | OPT.VatId |
      | ext-ALBERTA-001    | test_code | test_name | test_company    | null         | null      | de           | null    | test-group | null      |
    And verify that location was created for bpartner
      | bpartnerIdentifier | locationIdentifier | OPT.Address1  | OPT.Address2  | OPT.PoBox  | OPT.District | OPT.Region  | OPT.City  | CountryCode | OPT.Gln | OPT.Postal |
      | ext-ALBERTA-001    | gln-l11            | test_address1 | test_address2 | null       | null         | null        | null      | DE          | l11     | null       |
      | ext-ALBERTA-001    | gln-l22            | null          | test_address2 | test_poBox | null         | test_region | test_city | DE          | l22     | null       |
    And verify that contact was created for bpartner
      | bpartnerIdentifier | contactIdentifier | Name          | OPT.Email  | OPT.Fax  | Code |
      | ext-ALBERTA-001    | ext-ALBERTA-c11   | test_name_c11 | test_email | fax      | c11  |
      | ext-ALBERTA-001    | ext-ALBERTA-c22   | test_name_c22 | null       | test_fax | c22  |

  Scenario: Update a BPartner record
    When a 'PUT' request with the below payload is sent to the metasfresh REST-API 'api/v2-pre/bpartner/001' and fulfills with '201' status code
    """
{
   "requestItems":[
      {
         "bpartnerIdentifier":"ext-ALBERTA-001",
         "bpartnerComposite":{
            "bpartner":{
               "code":"test_code_updated",
               "name":"test_name_updated",
               "companyName":"test_company",
               "parentId":null,
               "phone":null,
               "language":"de",
               "url":"url_updated",
               "group":"test-group",
               "vatId":null
            }
         }
      }
   ],
   "syncAdvise":{
      "ifNotExists":"CREATE",
      "ifExists":"UPDATE_MERGE"
   }
}
"""
    Then verify that bPartner was updated for externalIdentifier
      | externalIdentifier | OPT.Code          | Name              | OPT.CompanyName | OPT.ParentId | OPT.Phone | OPT.Language | OPT.Url     | OPT.Group  | OPT.VatId |
      | ext-ALBERTA-001    | test_code_updated | test_name_updated | test_company    | null         | null      | de           | url_updated | test-group | null      |

  Scenario: Update a BPartner contact record
    When a 'PUT' request with the below payload is sent to the metasfresh REST-API 'api/v2-pre/bpartner/001' and fulfills with '201' status code
    """
{
   "requestItems":[
      {
         "bpartnerIdentifier":"ext-ALBERTA-001",
         "bpartnerComposite":{
            "contacts":{
               "requestItems":[
                  {
                     "contactIdentifier":"ext-ALBERTA-c11",
                     "contact":{
                        "code":"c11",
                        "name":"test_name_c11_updated",
                        "email":"test_email_updated",
                        "fax":"fax_updated"
                     }
                  }
               ]
            }
         }
      }
   ],
   "syncAdvise":{
      "ifNotExists":"CREATE",
      "ifExists":"UPDATE_MERGE"
   }
}
"""
    Then verify that contact was updated for bpartner
      | bpartnerIdentifier | contactIdentifier | Name                  | OPT.Email          | OPT.Fax     | Code |
      | ext-ALBERTA-001    | ext-ALBERTA-c11   | test_name_c11_updated | test_email_updated | fax_updated | c11  |