function  secBoard(n)
{
for(i=0;i<secTable.cells.length;i++)
secTable.cells[i].className="menu";
secTable.cells[n].className="menu_ab";
for(i=0;i<mainTable.tBodies.length;i++)
mainTable.tBodies[i].style.display="none";
mainTable.tBodies[n].style.display="block";
}

function  secBoardLeft(n)
{
for(i=0;i<secTableLeft.cells.length;i++)
secTableLeft.cells[i].className="center_project_nav_left";
secTableLeft.cells[n].className="center_project_nav_left_ab";
for(i=0;i<mainTableLeft.tBodies.length;i++)
mainTableLeft.tBodies[i].style.display="none";
mainTableLeft.tBodies[n].style.display="block";
}

function  secBoardRight(n)
{
for(i=0;i<secTableRight1.cells.length;i++)
secTableRight1.cells[i].className="center_project_nav_right";
secTableRight1.cells[n].className="center_project_nav_right_ab";
for(i=0;i<mainTableRight1.tBodies.length;i++)
mainTableRight1.tBodies[i].style.display="none";
mainTableRight1.tBodies[n].style.display="block";
}
