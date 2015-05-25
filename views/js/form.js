var App = {
  init: function() {
    console.log('in App.init')
    includeJs("js/md5.js");

    document.getElementById('base_email').addEventListener('keyup', App.refresh_thumbnail )
    document.getElementById('githubid_1').addEventListener('keyup', App.refresh_thumbnail )
    document.getElementById('githubid_2').addEventListener('keyup', App.refresh_thumbnail )
    document.getElementById('name_1'    ).addEventListener('keyup', App.refresh_thumbnail )
    document.getElementById('name_2'    ).addEventListener('keyup', App.refresh_thumbnail )
  },

  reveal_new_pair_form: function() {
    toggle_visibility("form-with-table");
    document.getElementById('githubid_1').focus()
  },

  refresh_thumbnail: function () {
    // refresh the email:
    var base_email_parts = document.getElementById("base_email").value.split('@');
    var replacements = {
      "%email_prefix%": base_email_parts[0],
      "%email_suffix%": base_email_parts[1],
      "%github_1%":     string_or(document.getElementById("githubid_1").value, '??'),
      "%github_2%":     string_or(document.getElementById("githubid_2").value, '??')
    }

    var pair_email = string_replace("%email_prefix%+%github_1%_%github_2%@%email_suffix%", replacements);;
    document.getElementById("pair_email").value = pair_email;

    var pair_email_decor = "%email_prefix%+<b>%github_1%</b>_<b>%github_2%</b><br>@%email_suffix%"
    document.getElementById("pair_future_email").innerHTML = string_replace(pair_email_decor, replacements);
    
    // refresh the avatar:
    gravatar_url = "http://gravatar.com/avatar/%gravatar_id%.png?d=identicon"
    gu = string_replace(gravatar_url, {'%gravatar_id%':md5(pair_email)});
    console.log(gu)
    document.getElementById("pair_future_avatar").src = gu

    // refresh the name:
    replacements = {
      "%name_1%":     string_or(document.getElementById("name_1").value, '??'),
      "%name_2%":     string_or(document.getElementById("name_2").value, '??')
    }

    var pair_name = "%name_1% + %name_2%"
    document.getElementById("pair_name").value = string_replace(pair_name, replacements);;
    
    var pair_name_decor = "<b>%name_1%</b> +<br><b>%name_2%</b>"
    document.getElementById("pair_future_name").innerHTML = string_replace(pair_name_decor, replacements);;
  },
}

//------------------------------------


// Extensions
function includeJs(jsFilePath) {
    var js = document.createElement("script");
    js.type = "text/javascript";
    js.src = jsFilePath;
    document.body.appendChild(js);
}
// includeJs("/md5.js");


function string_or(str, defau) {
  return str.length == 0 ? defau : str
}

function string_replace(model, replacements) {
  return model.replace(
      /%\w+%/g, 
      function(all) {return replacements[all] || all;}
    );
}

function toggle_visibility(id) {
   var e = document.getElementById(id);
   if(e.style.display == 'block')
      e.style.display = 'none';
   else
      e.style.display = 'block';
}
