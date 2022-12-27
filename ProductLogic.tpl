{$Debug = false} {*Change to true to print log*}

{$events.eventName = 'product viewed'} 
{$events.newerThan = "-1 days"|date_format:'Y-m-d\TH:i:sO'} 
{$events.properties = []} 
{$events.limit = 1}
{$events.sort = ['column'=>'ats','direction'=>'DESC']} 
{$browseditems = $utils->getEventRecords($events.eventName, $events.newerThan, $events.properties, $events.limit, $events.sort)}
{$counter = 0}

{foreach $browseditems as $item} {$prodid = $item.properties.id} 

    {if not in_array($prodid, $prod_array|default:[])} 

        {$prod_array[] = $prodid} 
        {$supplement_records.key = 'product_catalog_v2'}
        {$supplement_records.query = ['productID'=>{$prodid}]} 
        {$supplement_records.limit = 1} 
        {$supplement_records.sort = []} 
        {$supplement_records.data = $utils->getSupplementRecords($supplement_records.key, $supplement_records.query, $supplement_records.limit, $supplement_records.sort)} 

        {foreach $supplement_records.data as $item1} 
        
            {$contains_PLA.lookup_str = 'pla'} 
            {$contains_PLA.string = $item1.url} 
            
            {$contains_sale.lookup_str = 'Sale'} 
            {$contains_sale.string = $item1.productBadge} 
            
            {$contains_nonrx.lookup_str = 'Sale'} 
            {$contains_nonrx.string = $item1.productBadge}
            
            {$contains_safety47.lookup_str = '47-'} 
            {$contains_safety47.string = $item1.sku}
            
            {$contains_safety49.lookup_str = '49-'} 
            {$contains_safety49.string = $item1.sku}
            
            {$contains_safety69.lookup_str = '69-'} 
            {$contains_safety69.string = $item1.sku}

            {if not $utils->strContains($contains_PLA.lookup_str, $contains_PLA.string) && {$item1}} 
                {*Does NOT contain PLA. Continue.*} 
                {if $item1.frame_type|lower eq 'contact lenses'} 
                {$item1.coupon = "CONTACTS25"}
                 {$item1.discount_percentage = '25'}
                {$display = 'display:none !important; visibility:hidden; opacity:0;'} 
                {$item1.disc = "*Contacts25:This is an advertisement. Coupon only vaild for contact lenses."}
                {if not isset($utm)} 
                    {$utm = "utm_medium=product_abandon_contacts_25_1&utm_campaign=product_contacts_25_1"} 
                {/if} 

                {elseif $item1.productBadge|lower eq 'premium frames' and $item1.lens_type|lower eq 'non-rx' } 
                    {$item1.coupon = 'EXPRESS'} 
                    {$item1.disc = "* This is an advertisement. Contact lenses excluded. Limit one coupon code per purchase."}
                    {if not isset($utm)} 
                        {$utm = "utm_medium=product_abandon_non-rx-premium_express_1&utm_campaign=product_non-rx-premium_express_1"} 
                    {/if} 

                {elseif $item1.productBadge|lower eq 'premium frames'} 
                    {$item1.coupon = 'DESGINER25'}
                     {$item1.discount_percentage = '25'}
                    {$item1.disc = "DESIGNER25: 25% off coupon applies to Premium tagged frames only including Ray-Ban and Oakley. Free shipping
                    within US & Canada. Single-Vision Value lens package is free with eyeglasses frames only. Limited to one coupon code per purchase. Coupon not valid on items without the Premium tag."}
                    {if not isset($utm)} 
                        {$utm = "amp;utm_medium=product_abandon_DESGINER25_1&amp;utm_content=Not_HTO&amp;utm_campaign=product_DESGINER25_1"} 
                    {/if}
                                                                                    
                {elseif $item1.age_group|lower eq 'kids'} 
                    {$item1.coupon = 'Lenses60'}
                     {$item1.discount_percentage = '60'}
                    {$item1.disc = "* This is an advertisement. Contact lenses excluded. Limit one coupon code per purchase.
                    LENSES60: 60% Off is eligible for all lens package upgrades including blue light, hydrophobic, polarized, mirrored, tinted & Transitions. Free shipping for US & Canada. Limit is one coupon code per customer. Not eligible for Sale tagged items. Not eligible for contact lenses. Not eligible for progressive or bifocal lenses"}
                    {if not isset($utm)} 
                        {$utm = "amp;utm_medium=product_abandon_Lenses60_1&amp;utm_content=Not_HTO&amp;utm_campaign=product_Lenses60_1"} 
                    {/if}
                                                                                    
                {elseif $utils->strContains($contains_sale.lookup_str, $contains_sale.string)} 
                    {$item1.coupon = 'Get up to $100 off'} 
                    {$item1.disc = "* This is an advertisement. Contact lenses excluded. Limit one coupon code per purchase."} 
                    {if not isset($utm)}
                        {$utm = "amp;utm_medium=product_abandon_clearance_100_1&amp;utm_campaign=product_clearance_100_1"} 
                    {/if} 

                {elseif $utils->strContains($contains_safety47.lookup_str, $contains_safety47.string) or $utils->strContains($contains_safety49.lookup_str, $contains_safety49.string) or $utils->strContains($contains_safety69.lookup_str, $contains_safety69.string)}

                    {$item1.coupon = 'SAFETY25'}
                     {$item1.discount_percentage = '25'}
                    {$item1.disc = "* This is an advertisement. SAFETY25 coupon code applies to the entire order
                                    of items in protective goggles & glasses category only  Free shipping for US & Canada  Limit is one coupon code per customer  Coupon is eligible for frames, lenses, and all lens upgrades
                                    including blue light block, anti-reflective, UV protection & more  Single Vision value lens package included  Not eligible for Sale-tagged or items with marked-down price"} 
                    {if not isset($utm)}
                        {$utm = "amp;utm_medium=product_abandon_SAFETY25_1&amp;utm_campaign=product_SAFETY25_1"} 
                    {/if} 

                {elseif not $utils->strContains($contains_sale.lookup_str, $contains_sale.string) && not $item1.frame_type|lower eq 'contact lenses' && not $item1.frame_type|lower eq 'premium brands' && not $browcat|lower eq 'progressive'} 
                    {$item1.coupon = 'EMAILVIP65'}
                     {$item1.discount_percentage = '65'}
                    {$item1.disc = "EMAILVIP65: This is an advertisement. Limit one coupon code per purchase. For single-vision eyeglasses, discount applies to frames with Value Lens Package. For Rx. sunglasses, bifocals and progressive glasses discount applies to frames only. Lens upgrades available at additional cost. Higher prescriptions may require lens upgrades. PREMIUM tagged and marked down frames excluded."} 
                        {if not isset($utm)} 
                            {$utm = "utm_medium=product_abandon_generic_65_1&utm_campaign=product_generic_65_1"} 
                        {/if} 
                    {else}
                        {$item1.coupon = "EMAILVIP65"}
                        {$item1.discount_percentage = '65'}
                        {$item1.disc = "EMAILVIP65: This is an advertisement. Limit one coupon code per purchase. For single-vision eyeglasses, discount applies to frames with Value Lens Package. For Rx. sunglasses, bifocals and progressive glasses discount applies to frames only. Lens upgrades available at additional cost. Higher prescriptions may require
                        lens upgrades. PREMIUM tagged and marked down frames excluded."} 
                        {if not isset($utm)} 
                            {$utm = "utm_medium=product_abandon_generic_65_1&utm_campaign=product_generic_65_1"}
                        {/if} 
                {/if} 
            {else} 
            {continue} 
            {/if}
{if $item1.coupon && $counter < 2}
{$Banner = true}
{$banner_src = '#'}
{$banner_url = '#'}

{$ProdArray[] = [
        
        'coupon_text' => {$item1.coupon},
        'price' => {$item1.price},
        'desktop_image' => {$item1.images},
        'mobile_image' => {$item1.mobile_images},
        'disclaimer' => {$item1.disc},
        'name' => {$item1.productName},
        'discount' => {$item1.discount_percentage}
      ]
      }
{/if}
 {$counter = $counter+1} 
 {/foreach} 
 {$counter = $counter+1} 
 {else}
 {continue}
 {/if} 
 {/foreach}



{if $Debug}
{$utils->jsonPrettyPrint($ProdArray)}
{/if}
