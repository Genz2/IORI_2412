# The name of this view in Looker is "User Data"
view: user_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.user_data ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Max Num Orders" in Explore.

  dimension: max_num_orders {
    type: number
    sql: ${TABLE}.max_num_orders ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_max_num_orders {
    type: sum
    sql: ${max_num_orders} ;;  }



  measure: average_max_num_orders {
    type: average
    sql: ${max_num_orders} ;;  }

  dimension: total_num_orders {
    type: number
    sql: ${TABLE}.total_num_orders ;;
  }


  measure: ooa_rate {
    view_label: "Event Data"
    group_label: "Rates"
    label: "OOA Rate"
    description: "Percent of link clicks that were unsuccessful due to out of area"
    type: number
    value_format_name: percent_4
    sql: (0E0+${total_num_orders}) /(0E0+${max_num_orders}) ;;
  }




  measure: ooa_rate_test2 {
    view_label: "Event Data test 2"
    group_label: "Rates"
    label: "OOA Rate"
    description: "Percent of link clicks that were unsuccessful due to out of area"
    type: number
    value_format_name: percent_4

    sql: sum(${total_num_orders})/sum(${max_num_orders}) ;;

    }


  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count
    drill_fields: [id, users.id, users.first_name, users.last_name]
  }
}
