import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/src/controllers/order_controller.dart';
import 'package:restaurant_rlutter_ui/src/elements/CircularLoadingWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/OrderItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/SearchBarWidget.dart';

class OrdersWidget extends StatefulWidget {
  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends StateMVC<OrdersWidget> {
  OrderController _con;

  _OrdersWidgetState() : super(OrderController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Scaffold(
      key: _con.scaffoldKey,
      body: RefreshIndicator(
        onRefresh: _con.refreshOrders,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBarWidget(),
              ),
              SizedBox(height: 10),
              _con.orders.isEmpty
                  ? CircularLoadingWidget(height: 500)
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _con.orders.length,
                      itemBuilder: (context, index) {
                        return Theme(
                          data: theme,
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Row(
                              children: <Widget>[
                                Expanded(child: Text('Order Id: #${_con.orders.elementAt(index).id}')),
                                Text(
                                  '${_con.orders.elementAt(index).orderStatus.status}',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            children: List.generate(_con.orders.elementAt(index).foodOrders.length, (indexFood) {
                              return OrderItemWidget(
                                  heroTag: 'my_orders',
                                  order: _con.orders.elementAt(index),
                                  foodOrder: _con.orders.elementAt(index).foodOrders.elementAt(indexFood));
                            }),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
