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
            text: "Browse"
        }
        TabButton {
            text: "Stats"
        }
        TabButton {
            text: "Profile"
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
            StackView {
                id: browse
                initialItem: Page {
                    ListView {
                        model: 5
                        spacing: 5
                        anchors.margins: 5
                        anchors.fill: parent
                        delegate: Rectangle {
                            height: 200
                            width: parent.width
                            border.color: "black"
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text {
                                height: minimumHeight
                                text: "Game Title"
                                font.pixelSize: 20
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Rectangle {
                                height: parent.height-75
                                width: parent.width-75
                                anchors.margins: 25
                                anchors.top: parent.children[0].bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                                border.color: "blue"
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: browse.push(currentGame)
                                }
                                Text {
                                    text: "Game Image"
                                    anchors.centerIn: parent
                                }
                            }
                            Row {
                                spacing: 5
                                anchors.margins: 15
                                anchors.bottom: parent.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                                Text {
                                    text: "50"
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Row {
                                    width: parent.parent.children[1].width
                                    height: 20
                                    Rectangle {
                                        height: parent.height
                                        width: parent.width/2
                                        color: "lightgreen"
                                    }
                                    Rectangle {
                                        height: parent.height
                                        width: parent.width/2
                                        color: "#fb4a9d"
                                    }
                                }
                                Text {
                                    text: "50"
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }
                        footer: Text {
                            text: "Active Games: " + browse.initialItem.contentChildren[0].count
                        }
                    }
                }
                StackView {
                    id: currentGame
                    anchors.fill: parent
                    property variant gameLog: []
                    initialItem: Page {
                        anchors.fill: parent
                        Row {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            Button {
                                text: "Back"
                                onClicked: browse.pop()
                            }
                            Text {
                                height: parent.children[0].height
                                width: parent.width-parent.children[0].width-parent.children[2].width
                                text: "Current Game"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            Button {
                                text: "Game Log"
                                onClicked: currentGame.push(currentGame.children[0])
                            }
                        }
                        Row {
                            anchors.centerIn: parent
                            TextField {
                                property alias log: currentGame.gameLog
                                placeholderText: "Your Move...."
                                onLogChanged: text = ""
                                onAccepted: parent.children[1].clicked()
                            }
                            Button {
                                text: "Play"
                                onClicked: currentGame.gameLog = ([parent.children[0].text]).concat(currentGame.gameLog)
                            }
                        }
                    }
                    Page {
                        anchors.fill: parent
                        Button {
                            text: "Back"
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            onClicked: currentGame.pop()
                        }
                        ListView {
                            width: 200
                            height: 400
                            anchors.centerIn: parent
                            model: currentGame.gameLog
                            delegate: Text {
                                text: "Move " + index + ": " + modelData
                            }
                        }
                    }
                }
            }
            Page {
                id: leaderboard
                Text {
                    text: "Goodbye"
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
