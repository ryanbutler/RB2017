
    $(function () {
        //need the rendered id and not the static id used below
        $("#MainContent_FNameTB").focus();
        $('input[name="ctl00$MainContent$rblArticleQuestion"]').change(function () {
            if ($(this).val() == "Yes"){
                $("#whichArticle").show('10000');
            }
            else {
                $("#whichArticle").hide('10000');
                }
        })
       
    })