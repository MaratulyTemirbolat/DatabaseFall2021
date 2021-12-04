# DatabaseFall2021FinalProject
This file illustrates main description of the done project with the name "Electronics vendor". 

# Files Description:


Project short descrption:
  The database consists of the huge amount of the stores. Those stores have various number of the employees as well as warehouses where the corresponded products, packages are located.
  There are different types of the customers along with the orders that the puchase. The customers and orders can be online and offline respectively.
  The information about with type of the payment also considered in several cases. It can be card, cash or account. The customers can have accounts by which they made the purchases
  since they have contract with the company where they work. There are different addresses, regions, manufactures that produce various goods.
  It was necessary to consider the audit of the products in manufacturer, stores and send requests to the manufacturer if it was necessary to update the amount of products.
  Online orders made by the online customers are served and delivered by the shippers. The tracking for all the orders also considered to find the current location, state of the order.
  
Final Project table description:
    1) phones -- table is used to store the phone information about the employees 
    2) positions -- table that keeps the info about the working position of the employee in store 
    3) employees -- all the employees that work in store
    4) categories -- the categories by which goods types are devided
    5) types -- all the types by which goods are devided
    6) regions -- table includes the information about all regions that can exist 
    7) cities -- table illustrates the data abou all cities
    8) streets -- table with all existed streets
    9) manufacturers -- table with all existed manufacturers
    10) order_status -- table with all possible statuses of the order
    11) order_tracking -- table with all trackings for the orders where full information about current state of the order is
    12) shippers -- table with information about all existed shippers in the database
    13) shipper_tracking -- table that contains information for the shipper corresponded teacking number of the package
    14) stores -- table with the data about the all existed stores in the database with information where it is located
    15) products -- table with the whole existed products in the world that can be devided by the type,categories, manufactures etc.
    16) warehouses -- table with the information about warehouses that exist. It has the reference to the store to which it is attached.
    17) seasons -- table with all seasons 
    18) warehouse_manufacturer_audit -- table which is used to store info about the audit for sending requests to the manufacturers with required number of certain product
    19) store_warehouse_audit -- table which is used to keep data about the audit between store and warehouse by which it is attached to send certain products with required quantity.
    20) warehouse_inventory -- table to analyze the audit of the products in certain warehouse to make inventarization.
    21) account_numbers -- accounts with the information to the companies to which they correspond to.
    22) offline_customers -- table with all customers that were registered by making purchases in the stores.
    23) online_customers -- table with all customers that were registered by making purchases online
    24) cards -- table with information about cards for online customers
    25) account_bill -- table with description of the bills (number of months, montly payment) with corresponded accounts
    26) offline_orders -- table with the all info about made orders in the store
    27) online_orders -- table with the all info about made orders online
    28) store_inventory -- table with the store inventorization that illustrates the remained number of the specified product in the corresponded store and so on.
    29) online_order_products -- table with the all products that are combined for the corresponded order that was done online
    30) offline_order_products -- table with the all products that are combined for the corresponded order that was done offline
        
Views description:
  There are several views that were created in the database:
     1) all_customers -- was used to store information for all online and offline customers
     2) all_orders -- was created to store data for all online and offline made orders
     3) all_order_products -- was created to store info about the attached products for the whole orders

Procedure description:
   For solving problems with some activities such as update, insert etc procedures were created:
      1) create_destroyed_shipment -- was created since if the some orders were destroyed that were served by the shippers. It was necessary to reorganize the same order with the same products again.

Function description:
    To make some combined activities or get some required changed data it was required to construct the functions for triggers and for some actions.
      1) get_order_id -- function was used to get new id for the online and offline new orders
      2) get_customer_id -- function was constructed to obtain new id for the online and offlien new customers respectively
      3) update_function_trigger -- function was used to peform actions if the trigger for update_order_tracking_trigger was executed to start create_destroyed_shipment procedure

Trigger description:
    For some insertions, updations, deletions it was necessary to perform extra checks, activities and so on
      1) update_order_tracking_trigger -- trigger was created to be executed after the update for order_tracking table that calls function update_function_trigger that checks status.
          
