  function toggle(id) {
    var ele = document.getElementById("toggleText" + id);
    var text = document.getElementById("displayText" + id);
    if(ele.style.display == "block") {
      ele.style.display = "none";
      text.innerHTML = "Add Comment";
    }
    else {
      ele.style.display = "block";
      text.innerHTML = "";
    }
  }

  function addClick(){


    history.go();
  }

  function disableCheck(click){
    if (click > 1)
    {
      disable

    }

  }

