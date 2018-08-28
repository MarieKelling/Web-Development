var Home = {};          //Scopes everything inside of the 'Home Namespace' 


Home.InitialPageLoadEvent = function()
{
    $("h1").hide().show(1000)
}
Home.FocusBlurEvent = function()
{
    //focus blur events 
    $("input").focus(function () {
        $(this).css('background', 'pink');
    });
    $("input").blur(function () {
        $(this).css('background', 'white');
    });
}
Home.HideShowToggleEvent = function()
{
    $("#hide").click(function () {
        $("div").hide();
    });

    $("#show").click(function () {
        $("div").show();
    });

    $("#toggle").click(function () {
        $("div").toggle();
    });
}
Home.CoordEvent = function()
{
    $("document").on("mousemove", function (e) {
        $("#coords").html("Coords: Y: " + e.clientY + "X: " + e.clientX);
    });
}

Home.FadeEvent = function()
{
    $("#fade").click(function () {
        $(this).fadeOut(1000);
    });
}
Home.DragEvent = function()
{
    $("#drag").draggable();
}

$(document).ready(function () {

    Home.InitialPageLoadEvent();
    Home.FocusBlurEvent();
    Home.HideShowToggleEvent();

    Home.FadeEvent();
    Home.DragEvent();

    //Grab the value typed in input and alert it 
    //$("input").blur(function (e) {
    //    alert(e.target.value);
    //});
});