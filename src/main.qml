import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: screen
    visible: true
    width: 360
    height: 640
    title: qsTr("Chain Gang")
    header: TabBar {
        id: bar
        width: screen.width
        currentIndex: loggedIn.currentIndex
        TabButton {
            text: qsTr("Browse")
        }
        TabButton {
            text: qsTr("Stats")
        }
        TabButton {
            text: qsTr("Profile")
        }
    }

    StackView {
        id: main
        initialItem: loggedIn
        anchors.fill: parent
        Component.onCompleted: main.push(loggedOut)

        SwipeView {
            id: loggedIn
            currentIndex: bar.currentIndex
            anchors.fill: parent

            Page {
                id: browse
                Text {
                    text: "Hello!"
                    anchors.centerIn: parent
                }
            }
            Page {
                id: leaderboard
                Text {
                    text: "Goodbye!"
                    anchors.centerIn: parent
                }
            }
            Page {
                id: profile
                Text {
                    text: "I'm late, I'm late, I'm Late!"
                    anchors.centerIn: parent
                }
            }
        }
        Page {
            id: loggedOut
            anchors.fill: parent
            Button {
                width: screen.width/2
                height: width/2
                text: "Login!"
                anchors.centerIn: parent
                onClicked: main.pop()
            }
        }
    }
}
