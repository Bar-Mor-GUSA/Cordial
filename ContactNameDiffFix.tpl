
{* 
fix diff between contact name in order vs contact attribute
[DESCRIPTION]
- fix diff between contact name in order vs contact attribute

[REQUIREMENTS]

[AUTHOR: Bar Mor, GlassesUSA]
[VERSION: 1.0, 01/12/2022]
*}

{*=====Settings=====*}
{$lookup_key = "cID:{$dataRecord.cID}"}
{$contactRecord = $utils->setContact($lookup_key)}

{$utils->jsonPrettyPrint($dataRecord.cID)}

{$data.metadata = $utils->renderInfo()}
{$Debug = false} {* To Print Logs Change to True *}
{$orders=$utils->getOrders([],null,['column'=>'purchaseDate','direction'=>'DESC'])} 

{* Contact Attributes *}
{$lastName = $contact.lastname}
{$firstName = $contact.firstname}

{* Contact Attributes cart shipping *}
{$cart_shipping_attribute_first_name = $contact.cart_shipping_first_name}
{$cart_shipping_attribute_street = $contact.cart_shipping_street}
{$cart_shipping_attribute_city = $contact.cart_shipping_city}
{$cart_shipping_attribute_region_id = $contact.cart_shipping_region_id}
{$cart_shipping_attribute_region_name = $contact.cart_shipping_region_name}
{$cart_shipping_attribute_country_code = $contact.cart_shipping_country_code}
{$cart_shipping_attribute_phone = $contact.cart_shipping_phone}
{$cart_shipping_attribute_last_name = $contact.cart_shipping_last_name}
{$cart_shipping_attribute_postal_code = $contact.cart_shipping_postal_code}

{* Contact Attributes cart billing *}
{$cart_billing_attribute_street = $contact.cart_billing_street}
{$cart_billing_attribute_city = $contact.cart_billing_city}
{$cart_billing_attribute_region_id = $contact.cart_billing_region_id}
{$cart_billing_attribute_region_name = $contact.cart_billing_region_name}
{$cart_billing_attribute_country_code = $contact.cart_billing_country_code}
{$cart_billing_attribute_phone = $contact.cart_billing_phone}
{$cart_billing_attribute_last_name = $contact.cart_billing_last_name}
{$cart_billing_attribute_first_name = $contact.cart_billing_first_name}
{$cart_billing_attribute_postal_code = $contact.cart_billing_postal_code}
{*$cart_token_attribute = $contact.cart_token*}


{* Order Attributes *}

{* Order Attributes order shipping *}
{$order_shipping_attribute_first_name = $orders.0.properties.order_shipping_first_name}
{$order_shipping_attribute_street = $orders.0.properties.order_shipping_street}
{$order_shipping_attribute_city = $orders.0.properties.order_shipping_city}
{$order_shipping_attribute_region_id = $orders.0.properties.order_shipping_region_id}
{$order_shipping_attribute_region_name = $orders.0.properties.order_shipping_region_name}
{$order_shipping_attribute_country_code = $orders.0.properties.order_shipping_region_code}
{$order_shipping_attribute_phone = $orders.0.properties.order_shipping_phone}
{$order_shipping_attribute_last_name = $orders.0.properties.order_shipping_last_name}
{$order_shipping_attribute_postal_code = $orders.0.properties.order_shipping_postal_code}

{* Order Attributes order billing *}
{$order_billing_attribute_first_name = $orders.0.properties.order_billing_first_name}
{$order_billing_attribute_street = $orders.0.properties.order_billing_street}
{$order_billing_attribute_city = $orders.0.properties.order_billing_city}
{$order_billing_attribute_region_id = $orders.0.properties.order_billing_region_id}
{$order_billing_attribute_region_name = $orders.0.properties.order_billing_region_name}
{$order_billing_attribute_country_code = $orders.0.properties.order_billing_region_code}
{$order_billing_attribute_phone = $orders.0.properties.order_billing_phone}
{$order_billing_attribute_last_name = $orders.0.properties.order_billing_last_name}
{$order_billing_attribute_postal_code = $orders.0.properties.order_billing_postal_code}


{*=====SCRIPT=====*}

 
    {if $orders}
           
        {$updateRecord.data = [
            'firstname' => $order_shipping_attribute_first_name,
            'lastname' => $order_shipping_attribute_last_name,
            'cart_shipping_first_name' => $order_shipping_attribute_first_name,
            'cart_shipping_street' => $order_shipping_attribute_street,
            'cart_shipping_city' => $order_shipping_attribute_city,
            'cart_shipping_region_id' => $order_shipping_attribute_region_id,
            'cart_shipping_region_name' => $order_shipping_attribute_region_name,
            'cart_shipping_country_code' => $order_shipping_attribute_country_code,
            'cart_shipping_phone' => $order_shipping_attribute_phone,
            'cart_shipping_last_name' => $order_shipping_attribute_last_name,
            'cart_shipping_postal_code' => $order_shipping_attribute_postal_code,
            'cart_billing_first_name' => $order_billing_attribute_first_name,
            'cart_billing_street' => $order_billing_attribute_street,
            'cart_billing_city' => $order_billing_attribute_city,
            'cart_billing_region_id' => $order_billing_attribute_region_id,
            'cart_billing_region_name' => $order_billing_attribute_region_name,
            'cart_billing_country_code' => $order_billing_attribute_country_code,
            'cart_billing_phone' => $order_billing_attribute_phone,
            'cart_billing_last_name' => $order_billing_attribute_last_name,
            'cart_billing_postal_code' => $order_billing_attribute_postal_code
            ]} 
            1:  {$utils->jsonPrettyPrint($updateRecord.data)}
        {$updateRecord.waitForResult = false} 
        {$updateRecord.suppressTriggers = true}
        {$updateRecord.forceSubscribe = false}
              
        {if !empty($contactRecord)} 
        {$utils->jsonPrettyPrint($updateRecord.data)}
             {$contactRecord = $utils->updateContact($updateRecord.data, $updateRecord.waitForResult, $updateRecord.suppressTriggers, $updateRecord.forceSubscribe)}
        {/if} 
          
        {$log[] = 'true'}
    {/if}

  {$exp[] = [
          
            'cID' => {$contact.cID},
            'Order Name' => {$orderName},
            'Attribute Name' => {$attributeName},
            'Order Name' => {$orderName},
            'Attribute Phone' => {$attributePhone},
            'Order Phone' => {$orderPhone},
            'Date Joined' => {$contact.date_created},
            'Last modified date' => {$contact.lastModified},
            'Last modified source' => {$contact.lastUpdateSource},
            'subscribed from' => {$contact.subscribed_from}
          ]}

{if $data.metadata.preview && $Debug}
  <h2>Debug $log</h2>
  {$utils->jsonPrettyPrint($log)}<hr>
  <h2>Debug order date</h2>
  {$utils->jsonPrettyPrint($orderDate)}<hr>
   <h2>Debug $exp</h2>
  {$utils->jsonPrettyPrint($exp)}<hr>
  <h2>Debug Name</h2>
  Order Name: {$utils->jsonPrettyPrint($nameArray)}<hr>
  Attribute Name: {$utils->jsonPrettyPrint($attributeName)}<hr>
  <h2>Debug Phone</h2>
  Order Phone: {$utils->jsonPrettyPrint($phoneArray)}<hr>
  Attribute Phone: {$utils->jsonPrettyPrint($attributePhone)}<hr>
{/if}
