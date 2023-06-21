

// void emailListener(TextEditingController controller , bool validationStatus) {
//     String text = controller.text;
//     log(text);
//     if (!validationStatus && text.isValidEmail()) {
//       setState(() {
//         validationStatus = true;
//       });
//     }
//     if (validationStatus && !text.isValidEmail()) {
//       setState(() {
//         validationStatus = false;
//       });
//       // the tricky part is to make this part more dynamic as to decide whome should I notify what 
//     }
//   }