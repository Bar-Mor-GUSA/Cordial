{$Debug = false} {*Change to true to print log*}

{$counter = 0}
{foreach $contact.cart.cartitems as $item}
{if $counter > 2 }{break}{/if}

{if not in_array($item.productID, $prod_array|default:[])}
    {$supplement_records.key = 'product_catalog_v2'} 
    {$supplement_records.query = ['productID'=>$item.productID]} 
    {$supplement_records.limit = 1} 
    {$supplement_records.sort = []} 
    {$supplement_records.data = $utils->getSupplementRecords($supplement_records.key, $supplement_records.query, $supplement_records.limit, $supplement_records.sort)} 
    {$item1 = $supplement_records.data.0}


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
    {*Does NOT contain PLA.  Continue.*}
        {if $item1.frame_type|lower eq 'contact lenses'}
            {$item1.coupon = "Get 25% OFF your contact lenses | Use code: CONTACTS25"}
            {$subject_1 = "25% Off Your Favorite Contact Lenses From GlassesUSA.com"}
            {$subject_2 = "Your shopping cart is waiting for you. Can we help?"}
            {$subject_3 = "Last Reminder! 25% Off Your Favorite Contact Lenses"}
            {$subject_4 = "🕚 We are holding your cart... only until tonight!"}
            {$item1.disc = "*Contacts25:This is an advertisement. Coupon only vaild for contact lenses."}
            {$utm_1 = "utm_source=newsletter&utm_medium=cart_abandon_contacts_20_1&utm_campaign=cart_contacts_20_1"}
            {$utm_2 = "utm_source=newsletter&utm_medium=cart_abandon_contacts_20_2&utm_campaign=cart_contacts_20_2"}
            {$utm_3 = "utm_source=newsletter&utm_medium=cart_abandon_contacts_20_3&utm_campaign=cart_contacts_20_3"}
            {$utm_4 = "utm_source=newsletter&utm_medium=cart_abandon_contacts_20_4&utm_campaign=cart_contacts_20_4"}
            {$display = 'display:none !important; visibility:hidden; opacity:0;'}
                

        {elseif $item.properties.divided_sku[2]|lower eq 'progressive' or $item.properties.divided_sku[2]|lower eq 'bifocal'}
            {if $item.itemPrice gte 199 and $item.itemPrice lte 249}
                {$item1.coupon = 'Order now & get $50 OFF progressives | Code: MULTI50'}
                {$subject_1 = "$50 Off + Free Shipping on Your Progressives From GlassesUSA.com"}
                {$subject_2 = "Your shopping cart is waiting for you. Want $50 off progressives?"}
                {$subject_3 = "Last Reminder! $50 Off + Free Shipping on Your Glasses"}
                {$subject_4 = "🔔 Last Chance! $50 Off + Free Shipping on Your Glasses"}
                {$item1.disc = "MULTI50:$50 off multifocal orders above $199.<br>
                                MULTI75: $75 off multifocal orders above $249.<br>
                                MULTI150: $150 off multifocal orders above $399.<br>
                                *Offers only valid on orders with progressive and bifocal lenses."}
                {$utm_1 = "utm_source=newsletter&utm_medium=cart_abandon_multi50_1&utm_campaign=cart_multi50_1"}
                {$utm_2 = "utm_source=newsletter&utm_medium=cart_abandon_multi50_2&utm_campaign=cart_multi50_2"}
                {$utm_3 = "utm_source=newsletter&utm_medium=cart_abandon_multi50_3&utm_campaign=cart_multi50_3"}
                {$utm_4 = "utm_source=newsletter&utm_medium=cart_abandon_multi50_4&utm_campaign=cart_multi50_4"}
                {$display = 'display:none !important; visibility:hidden; opacity:0;'}
            {elseif $item.itemPrice gte 250 and $item.itemPrice lte 399}
                {$item1.coupon = 'Order now & get $75 OFF progressives | Code: MULTI75'}
                {$subject_1 = "$75 Off + Free Shipping on Your Progressives From GlassesUSA.com"}
                {$subject_2 = "Your shopping cart is waiting for you. Want $75 off progressives?"}
                {$subject_3 = "Last Reminder! $75 Off + Free Shipping on Your Glasses"}
                {$subject_4 = "🔔 Last Chance! $75 Off + Free Shipping on Your Glasses"}
                {$item1.disc = "MULTI50:$50 off multifocal orders above $199.<br>
                                MULTI75: $75 off multifocal orders above $249.<br>
                                MULTI150: $150 off multifocal orders above $399.<br>
                                *Offers only valid on orders with progressive and bifocal lenses."}
                {$utm_1 = "utm_source=newsletter&utm_medium=cart_abandon_multi75_1&utm_campaign=cart_multi75_1"}
                {$utm_2 = "utm_source=newsletter&utm_medium=cart_abandon_multi75_2&utm_campaign=cart_multi75_2"}
                {$utm_3 = "utm_source=newsletter&utm_medium=cart_abandon_multi75_3&utm_campaign=cart_multi75_3"}
                {$utm_4 = "utm_source=newsletter&utm_medium=cart_abandon_multi75_4&utm_campaign=cart_multi75_4"}
                {$display = 'display:none !important; visibility:hidden; opacity:0;'}
            {elseif $item.itemPrice gte 400}
                {$item1.coupon = 'Order now & get $150 OFF progressives | Code: MULTI150'}
                {$subject_1 = "$150 Off + Free Shipping on Your Progressives From GlassesUSA.com"}
                {$subject_2 = "Your shopping cart is waiting for you. Want $150 off progressives?"}
                {$subject_3 = "Last Reminder! $150 Off + Free Shipping on Your Glasses"}
                {$subject_4 = "🔔 Last Chance! $150 Off + Free Shipping on Your Glasses"}
                {$item1.disc = "MULTI50:$50 off multifocal orders above $199.<br>
                                MULTI75: $75 off multifocal orders above $249.<br>
                                MULTI150: $150 off multifocal orders above $399.<br>
                                *Offers only valid on orders with progressive and bifocal lenses."}
                {$utm_1 = "utm_source=newsletter&utm_medium=cart_abandon_multi150_1&utm_campaign=cart_multi150_1"}
                {$utm_2 = "utm_source=newsletter&utm_medium=cart_abandon_multi150_2&utm_campaign=cart_multi150_2"}
                {$utm_3 = "utm_source=newsletter&utm_medium=cart_abandon_multi150_3&utm_campaign=cart_multi150_3"}
                {$utm_4 = "utm_source=newsletter&utm_medium=cart_abandon_multi150_4&utm_campaign=cart_multi150_4"}
                {$display = 'display:none !important; visibility:hidden; opacity:0;'}
            {else}
                {$item1.coupon = "Order now & get 65% OFF the frame | Use code: EMAILVIP65"}
                {$subject_1 = "65% Off + Free Shipping on Your Frames From GlassesUSA.com"}
                {$subject_2 = "Your shopping cart is waiting for you. Can we help?"}
                {$subject_3 = "Last Reminder! 65% Off + Free Shipping on Your Frames"}
                {$subject_4 = "🔔 Last Chance! 65% Off + Free Shipping on Your Frames"}
                {$utm_1 = "utm_source=newsletter&utm_medium=cart_abandon_generic_65_1&utm_campaign=cart_generic_65_1"}
                {$utm_2 = "utm_source=newsletter&utm_medium=cart_abandon_generic_65_2&utm_campaign=cart_generic_65_2"}
                {$utm_3 = "utm_source=newsletter&utm_medium=cart_abandon_generic_65_3&utm_campaign=cart_generic_65_3"}
                {$utm_4 = "utm_source=newsletter&utm_medium=cart_abandon_generic_65_4&utm_campaign=cart_generic_65_4"}
                {$item1.disc = "EMAILVIP65: This is an advertisement. Limit one coupon code per purchase. For single-vision eyeglasses, discount applies to frames with Value Lens Package. For Rx. sunglasses, bifocals and progressive glasses discount applies to frames only. Lens upgrades available at additional cost. Higher prescriptions may require lens upgrades. PREMIUM tagged and marked down frames excluded."}
                
            {/if}
        {elseif $item1.productBadge|lower eq 'premium frames' and $item1.lens_type|lower eq 'non-rx' }
            {$item1.coupon = 'Order now & get FREE express shipping | Code: EXPRESS'}
            {$subject_1 = "Come back for a free sitewide offer from GlassesUSA.com! Risk free shopping..."}
            {$subject_2 = "Your shopping cart is waiting for you. Can we help?"}
            {$subject_3 = "🚚 FREE Express Shipping on your ENTIRE Cart at GlassesUSA.com"}
            {$subject_4 = "🔔 Last Chance For FREE Express Shipping! Your cart expires tonight..."}
            {$utm_1 = "utm_source=newsletter&utm_medium=cart_abandon_non-rx-premium_express_1&utm_campaign=cart_non-rx-premium_express_1"}
            {$utm_2 = "utm_source=newsletter&utm_medium=cart_abandon_non-rx-premium_express_2&utm_campaign=cart_non-rx-premium_express_2"}
            {$utm_3 = "utm_source=newsletter&utm_medium=cart_abandon_non-rx-premium_express_3&utm_campaign=cart_non-rx-premium_express_3"}
            {$utm_4 = "utm_source=newsletter&utm_medium=cart_abandon_non-rx-premium_express_4&utm_campaign=cart_non-rx-premium_express_4"}
            {$item1.disc = "* This is an advertisement. Contact lenses excluded. Limit one coupon code per purchase."}


        {elseif $item1.productBadge|lower eq 'premium frames' and $item.itemPrice lte 200}
            {$item1.coupon = 'Get 25% OFF all designer frames | Use code: DESIGNER25'}
            {$subject_1 = "Come Back and Enjoy 25% Off Your Frame (all brands included)!"}
            {$subject_2 = "Your shopping cart is waiting for you. Can we help?"}
            {$subject_3 = "25% Off Your Frame at GlassesUSA.com"}
            {$subject_4 = "🔔 Last Chance For 25% Off EVERYTHING! Your cart expires tonight..."}
            {$utm_1 = "utm_source=newsletter&amp;utm_medium=cart_abandon_unique20_below-200_1&amp;utm_campaign=cart_unique20_below-200_1"}
            {$utm_2 = "utm_source=newsletter&amp;utm_medium=cart_abandon_unique20_below-200_2&amp;utm_campaign=cart_unique20_below-200_2"}
            {$utm_3 = "utm_source=newsletter&amp;utm_medium=cart_abandon_unique20_below-200_3&amp;utm_campaign=cart_unique20_below-200_3"}
            {$utm_4 = "utm_source=newsletter&amp;utm_medium=cart_abandon_unique20_below-200_4&amp;utm_campaign=cart_unique20_below-200_4"}
            {$item1.disc = "DESIGNER25: 25% off coupon applies to Premium tagged frames only including Ray-Ban and Oakley. Free shipping within US & Canada. Single-Vision Value lens package is free with eyeglasses frames only. Limited to one coupon code per purchase. Coupon not valid on items without the Premium tag."}

                                                
        {elseif $item1.productBadge|lower eq 'premium frames' and $item.itemPrice gte 199 or $item1.age_group|lower eq 'kids'}
            {$item1.coupon = 'Order now & get 60% OFF lens upgrades | Code: LENSES60'}
            {$subject_1 = "Come Back and Enjoy 60% Off All Lenses From GlassesUSA.com"}
            {$subject_2 = "Your shopping cart is waiting for you. Can we help?"}
            {$subject_3 = "Last Reminder! 60% Off + Free Shipping on Your Lenses"}
            {$subject_4 = "🔔 Last Chance! 60% Off + Free Shipping on Your Lenses"}
            {$item1.disc = "* This is an advertisement. Contact lenses excluded. Limit one coupon code per purchase.
                            LENSES60: 60% Off is eligible for all lens package upgrades including blue light, hydrophobic, polarized, mirrored, tinted & Transitions. 
                            Free shipping for US & Canada. Limit is one coupon code per customer. Not eligible for Sale tagged items. Not eligible for contact lenses. Not eligible for progressive or bifocal lenses"}
            {$utm_1 = "utm_source=newsletter&amp;utm_medium=cart_abandon_lenses60_above-200_1&amp;utm_content=Not_HTO&amp;utm_campaign=cart_lenses60_above-200_1"}
            {$utm_2 = "utm_source=newsletter&amp;utm_medium=cart_abandon_lenses60_above-200_2&amp;utm_content=Not_HTO&amp;utm_campaign=cart_lenses60_above-200_2"}
            {$utm_3 = "utm_source=newsletter&amp;utm_medium=cart_abandon_lenses60_above-200_3&amp;utm_content=Not_HTO&amp;utm_campaign=cart_lenses60_above-200_3"}
            {$utm_4 = "utm_source=newsletter&amp;utm_medium=cart_abandon_lenses60_above-200_4&amp;utm_content=Not_HTO&amp;utm_campaign=cart_lenses60_above-200_4"}

        {elseif $utils->strContains($contains_sale.lookup_str, $contains_sale.string)}
            {$item1.coupon = 'Get $100 OFF your entire order | Use code: SAVE100'}
            {$subject_1 = "Come Back For Up to $100 Off at GlassesUSA.com"}
            {$subject_2 = "Your shopping cart is waiting for you. Can we help?"}
            {$subject_3 = "Last Reminder! Up to $100 Off Your Glasses"}
            {$subject_4 = "🔔 Last Chance! Up to $100 Off Your Glasses"}
            {$utm_1 = "utm_source=newsletter&amp;utm_medium=cart_abandon_clearance_100_1&amp;utm_campaign=cart_clearance_100_1"}
            {$utm_2 = "utm_source=newsletter&amp;utm_medium=cart_abandon_clearance_100_2&amp;utm_campaign=cart_clearance_100_2"}
            {$utm_3 = "utm_source=newsletter&amp;utm_medium=cart_abandon_clearance_100_3&amp;utm_campaign=cart_clearance_100_3"}
            {$utm_4 = "utm_source=newsletter&amp;utm_medium=cart_abandon_clearance_100_4&amp;utm_campaign=cart_clearance_100_4"}
            {$item1.disc = "* This is an advertisement. Contact lenses excluded. Limit one coupon code per purchase."}
            


        {elseif $utils->strContains($contains_safety47.lookup_str, $contains_safety47.string) or $utils->strContains($contains_safety49.lookup_str, $contains_safety49.string) or $utils->strContains($contains_safety69.lookup_str, $contains_safety69.string)}
            {$item1.coupon = 'Get 25% OFF your order of safety glasses | Code: SAFETY25'}
            {$subject_1 = "25% Off + Free Shipping on Your Frames From GlassesUSA.com"}
            {$subject_2 = "Your shopping cart is waiting for you. Can we help?"}
            {$subject_3 = "Last Reminder! 25% Off + Free Shipping on Your Glasses"}
            {$subject_4 = "🔔 Last Chance! 25% Off + Free Shipping on Your Glasses"}
            {$item1.disc = "* This is an advertisement. SAFETY25 coupon code applies to the entire order
                            of items in protective goggles & glasses category only  Free shipping for US & Canada  Limit is one coupon code per customer  Coupon is eligible for frames, lenses, and all lens upgrades including blue light block, anti-reflective, UV protection & more  Single Vision value lens package included  Not eligible for Sale-tagged or items with marked-down price"}
            {$utm_1 = "utm_source=newsletter&utm_medium=cart_abandon_SAFETY25_1&utm_campaign=cart_SAFETY25_1"}
            {$utm_2 = "utm_source=newsletter&utm_medium=cart_abandon_SAFETY25_2&utm_campaign=cart_SAFETY25_2"}
            {$utm_3 = "utm_source=newsletter&utm_medium=cart_abandon_SAFETY25_3&utm_campaign=cart_SAFETY25_3"}
            {$utm_4 = "utm_source=newsletter&utm_medium=cart_abandon_SAFETY25_4&utm_campaign=cart_SAFETY25_4"}
        {elseif not $utils->strContains($contains_sale.lookup_str, $contains_sale.string) && not $item1.frame_type|lower eq 'contact lenses' && not $item1.frame_type|lower eq 'premium brands' && not $item.properties.divided_sku[2]|lower eq 'progressive'}
            {$item1.coupon = 'Order now & get 65% OFF the frame | Use code: EMAILVIP65'}
            {$subject_1 = "65% Off + Free Shipping on Your Frames From GlassesUSA.com"}
            {$subject_2 = "Your shopping cart is waiting for you. Can we help?"}
            {$subject_3 = "Last Reminder! 65% Off + Free Shipping on Your Frames"}
            {$subject_4 = "🔔 Last Chance! 65% Off + Free Shipping on Your Frames"}
            {$item1.disc = "EMAILVIP65: This is an advertisement. Limit one coupon code per purchase. For single-vision eyeglasses, discount applies to frames with Value Lens Package. For Rx. sunglasses, bifocals and progressive glasses discount applies to frames only. Lens upgrades available at additional cost. Higher prescriptions may require lens upgrades. PREMIUM tagged and marked down frames excluded.Not valid for kids' glasses (premium & non-premium)"}
            {$utm_1 = "utm_source=newsletter&utm_medium=cart_abandon_EMAILVIP65_1&utm_campaign=cart_EMAILVIP65_1"}
            {$utm_2 = "utm_source=newsletter&utm_medium=cart_abandon_EMAILVIP65_2&utm_campaign=cart_EMAILVIP65_2"}
            {$utm_3 = "utm_source=newsletter&utm_medium=cart_abandon_EMAILVIP65_3&utm_campaign=cart_EMAILVIP65_3"}
            {$utm_4 = "utm_source=newsletter&utm_medium=cart_abandon_EMAILVIP65_4&utm_campaign=cart_EMAILVIP65_4"}
        {else}
            {$item1.coupon = "Buy one pair, get another one free | Use code: BOGOFREE"}
            {$subject_1 = "Buy 1 Get 1 FREE + Free Shipping From GlassesUSA.com"}
            {$subject_2 = "Your shopping cart is waiting for you. Can we help?"}
            {$subject_3 = "Last Reminder! Buy 1 Get 1 FREE + Free Shipping on Your Frames"}
            {$subject_4 = "🎁 Empty your cart with Buy 1 Get 1 FREE"}
            {$utm_1 = "utm_source=newsletter&utm_medium=cart_abandon_BOGOFREE_1&utm_campaign=cart_BOGOFREE_1"}
            {$utm_2 = "utm_source=newsletter&utm_medium=cart_abandon_BOGOFREE_2&utm_campaign=cart_BOGOFREE_2"}
            {$utm_3 = "utm_source=newsletter&utm_medium=cart_abandon_BOGOFREE_3&utm_campaign=cart_BOGOFREE_3"}
            {$utm_4 = "utm_source=newsletter&utm_medium=cart_abandon_BOGOFREE_4&utm_campaign=cart_BOGOFREE_4"}
            {$item1.disc = "BOGOFREE: Free shipping in the US & Canada. Get second pair for free, discount applies to the cheaper of the two glasses."}


        {/if}


        {else}
        {continue}
    {/if}
{$prod_array[$item.productID] = $item1}
{/if}



{if $item1.coupon && $counter < 2}
{$Banner = true}
{$banner_src = 'https://s3.us-east-1.amazonaws.com/files.glassesusa.com/0_Banners/FSA/FSA-TOP.gif'}
{$banner_url = '#'}

{$ProdArray[] = [
        
        'coupon_text' => {$item1.coupon},
        'subjectline_1' => {$subject_1},
        'subjectline_2' => {$subject_2},
        'subjectline_3' => {$subject_3},
        'desktop_image' => {$item1.images},
        'mobile_image' => {$item1.mobile_images},
        'disclaimer' => {$item1.disc},
        
        'name' => {$item.name}
      ]}
{/if}
 {$counter = $counter+1}
{/foreach}

{if $Debug}
{$utils->jsonPrettyPrint($ProdArray)}
{/if}
