import QtQuick 2.7

Page1Form {
    Connections {
            target: appCore // Указываем целевое соединение
            /* Объявляем и реализуем функцию, как параметр
             * объекта и с имененем похожим на название сигнала
             * Разница в том, что добавляем в начале on и далее пишем
             * с заглавной буквы
             * */
            onSendGetStarted: {
                swipeView.currentIndex = 1

            }
        }
    Component.onCompleted: {
        appCore.tests();
        //appCore.receiveAccounts();
    }
    getStarted.onClicked: {
        console.log("Button Pressed getStarted");
        appCore.receiveGetStarted()
    }
}
