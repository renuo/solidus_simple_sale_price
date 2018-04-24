Deface::Override.new(virtual_path: 'spree/admin/prices/_form',
                     name: 'edit_price_and_sale_price',
                     replace: "[data-hook='admin_product_price_form_amount']",
                     partial: 'spree/admin/sale_prices/form_field',
                     disabled: false)

Deface::Override.new(virtual_path: 'spree/admin/prices/_master_variant_table',
                     name: 'extend_price_table_with_original_and_sale_price_title',
                     replace: "[data-hook='master_prices_header'] > tr > th:nth-child(3)",
                     text: '<th><%= Spree::Price.human_attribute_name(:orginal_price) %></th>'\
                           '<th><%= Spree::Price.human_attribute_name(:sale_price) %></th>',
                     disabled: false)

Deface::Override.new(virtual_path: 'spree/admin/prices/_master_variant_table',
                     name: 'extend_price_table_with_original_and_sale_price_columns',
                     replace: "[data-hook='prices_row'] > td:nth-child(3)",
                     text: '<td><%= price.original_amount %></td>'\
                           '<td><%= price.sale_amount %></td>',
                     disabled: false)
