import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

PaddedRectangle {

    id: userWidget
    property int userId
    property string userName
    property string userLastname
    property string userNatId
    property string userJobPosition
    property bool userEnabled
    property bool userAdmin
    property bool userIsFemale

    width: 256
    height: 230
    color:(userEnabled)? "white" : "lightpink"
    opacity: 0.8
    padding: -5
    radius: 10

    function updatePage(User)
    {
        userName = User["name"];
        userLastname = User["lastname"]
        userNatId = User["nat_id"];
        userJobPosition = User["job_position"];
        userEnabled = User["enabled"];
        userAdmin = User["admin"];
        userIsFemale = (User["gender"] === "خانم") ? true : false;
    }

    Image {
        source:"qrc:/Assets/images/setting2.png";
        visible:  (userAdmin)? true: false;
        width: 32
        height: 32
        anchors.top: parent.top
        anchors.right: parent.right
    }

    ColumnLayout
    {
        id: userWidgetCL
        anchors.fill: parent

        Image {
            source: (userIsFemale)? "qrc:/Assets/images/female.png" : "qrc:/Assets/images/user.png"
            Layout.preferredWidth: 128
            Layout.preferredHeight: 128
            Layout.alignment: Qt.AlignHCenter
        }
        Text {
            text: userName + " " + userLastname
            font.family: yekanFont.font.family
            font.pixelSize: 16
            font.bold: true
            color: "royalblue"
            Layout.preferredWidth: parent.width
            horizontalAlignment: Text.AlignHCenter
        }
        Text {
            text: "کدملی" + " : " + userNatId
            font.family: yekanFont.font.family
            font.pixelSize: 16
            font.bold: true
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: true
        }
        Text {
            text: "پست‌شغلی" + " : " + userJobPosition
            font.family: yekanFont.font.family
            font.pixelSize: 16
            font.bold: true
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: true
        }

    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        onHoveredChanged: (containsMouse)? parent.opacity=1 : parent.opacity=0.8
        onClicked: {
            homeStackViewId.push(userComponent, {userId: userId});
        }
    }

    Component
    {
        id: userComponent
        User{}
    }

}
