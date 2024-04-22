$((function () 
{
    $(".desktop").hide()
    $("#desktop1").show()
    $(".btn1").on("click", function () 
    {
        if ($(this).parent().parent().attr("id") === "desktop1") 
        {
            alert("already on desktop 1")
            return
        }
        $(this).parent().parent().slideUp("slow")
        $("#desktop1").slideDown("slow")
    })
    $(".btn2").on("click", function () 
    {
        if ($(this).parent().parent().attr("id") === "desktop2") 
        {
            alert("already on desktop 2")
            return
        }
        $(this).parent().parent().slideUp("slow")
        $("#desktop2").slideDown("slow")
    })
    $(".btn3").on("click", function () 
    {
        if ($(this).parent().parent().attr("id") === "desktop3") 
        {
            alert("already on desktop 3")
            return
        }
        $(this).parent().parent().slideUp("slow")
        $("#desktop3").slideDown("slow")
    })
    $(".btn4").on("click", function () 
    {
        if ($(this).parent().parent().attr("id") === "desktop4") 
        {
            alert("already on desktop 4")
            return
        }
        $(this).parent().parent().slideUp("slow")
        $("#desktop4").slideDown("slow")
    })
}));