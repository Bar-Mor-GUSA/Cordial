
{* 
Check diff between contact name in order vs contact attribute
[DESCRIPTION]
- Check diff between contact name in order vs contact attribute

[REQUIREMENTS]

[AUTHOR: Bar Mor, GlassesUSA]
[VERSION: 2.1, 27/11/2022]
*}

{*=====Settings=====*}
{$data.metadata = $utils->renderInfo()}
{$Debug = false} {* To Print Logs Change to True *}
{$nameArray = []}
{$phoneArray = []}
{$attributeName = $contact.firstname|lower|trim:" "}
{$attributePhone = $contact.cart_billing_phone|regex_replace:"/[\-()+[:space:]\+1]/":""}


{*=====SCRIPT=====*}
{$orders=$utils->getOrders([],null,['column'=>'purchaseDate','direction'=>'DESC'])} 

{foreach $orders as $order}

{if $order@iteration <= 1 }{$orderDate = $order.purchaseDate}{/if}

{$orderName =  $order.properties.order_billing_first_name|lower|trim:" "}
{$orderPhone = $order.properties.order_billing_phone|regex_replace:"/[\-()+[:space:]\+1]/":""}


{if not empty($orderPhone) && not empty($orderName) && not empty($attributeName) && not empty($attributePhone)}

{$tmpName = array_push($nameArray, $orderName)}
{$tmpPhone = array_push($phoneArray, $orderPhone)}

      
      {else} 

    {continue}
  {/if}
 {/foreach} 

  
   
 
    {if not empty($orderPhone) && not empty($orderName) && not empty($attributeName) && not empty($attributePhone) && 
        not in_array($attributePhone, $phoneArray) && 
        not in_array($attributeName, $nameArray)}
           
           {$export_record.file_identifier = 'export_diff_14'}
           {$export_record.row.cID = $contact.cID}
   
           {$utils->addExportRecord($export_record.file_identifier, $export_record.row)}
          
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
