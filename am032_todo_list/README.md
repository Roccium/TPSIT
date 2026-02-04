# am032_todo_list

**vr.251223**

In questa nuova versione abbiamo introdotto il *provider* - rimandiamo agli esempi - in modo da proporre
una più organizzata *business logic*. La vecchia versione si trova nella cartella `old`.

## gestioni dell notifiche

La classe `TodoListNotifier`

## model

La classe 
```dart
class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}
```
definisce il *model* per gli *item* della lista.

## dialog

Il metodo `showDialog<T>` in [2] ci ha permesso di creare il nostro *dialog*
```dart
barrierDismissible: false,
```
sta ad indicare [2] che il *dialog* resta visibile anche se tocchiamo fuori da esso. La classe `AlertDialog` [è la classe *basic* per i *dialog* in *Material Design*, invitiamo alla lettura delle API in [1]. L'istruzione
```dart
Navigator.pop(context);
```
l'abbiamo vista all'opera col *router*.

## la lista e i suoi elementi

`ListView.builder(..)` è *named constructor* che permette di costruire la lista. Legare a *widget* di uno stesso tipo valori di `key` differenti è importante, qui scegliamo
```dart
: super(key: ObjectKey(todo));
```


## materiali

[1] `AlertDialog` [qui](https://api.flutter.dev/flutter/material/AlertDialog-class.html).  
[2] `showDialog<T>` [qui](https://api.flutter.dev/flutter/material/showDialog.html).   
[3] `ListView` [qui](https://api.flutter.dev/flutter/widgets/ListView-class.html).  
