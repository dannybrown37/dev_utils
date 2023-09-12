#SingleInstance Force

; bash stuff
::,,br::~/.bashrc
::,,sbr::source ~/.bashrc
::,,cbr::code ~/.bashrc


; python stuff
::,,ifn::if __name__ == '__main__':
::,,log::logger = logging.getLogger(__name__)
::,,rst::ruff src tests


; venv stuff
::,,pmv::python -m venv .venv
::,,vba::source .venv/bin/activate
::,,nuke::deactivate && rm -r .venv && python -m venv .venv && source .venv/bin/activate


; pytest stuff
::,,ptt::pytest tests
::,,ptu::pytest tests/unit
::,,pte::pytest tests/e2e
::,,ptc::pytest tests/e2e/cloud
::,,ptl::pytest tests/e2e/local


; pip stuff
::,,pir::pip install -r requirements.txt
::,,pirdev::pip install -r requirements.dev.txt
::,,pirdocs::pip install -r requirements.docs.txt
::,,pie::pip install -e .
::,,puf::pip freeze | xargs pip uninstall -y   ; "pip uninstall freeze", removes all packages installed


; git stuff
::,,gap::git add -p
::,,gc::git commit -m "
::,,gca::git commit --amend -m "
::,,gcc::git commit -m "chore:
::,,gcfix::git commit -m "fix:
::,,gcfeat::git commit -m "feat:
::,,gcmajor::git commit -m "BREAKING CHANGE:
::,,gcr::git commit --amend --no-edit  ; "git commit rebase", updates last commit
::,,grh::git rebase -i HEAD~
::,,grd::git rebase develop
::,,grm::git rebase main
::,,gco::git checkout
::,,gcb::git checkout -b
::,,gcd::git checkout develop
::,,gcm::git checkout main
::,,gcl::git checkout -
::,,gp::git push
::,,gpf::git push -f
::,,gpo::git push -u origin
::,,glo::git log -1 --pretty=%B ; shows last commit message
::,,gitpurge::git branch | grep -v -e "main" -e "develop" -e "$(git rev-parse --abbrev-ref HEAD)" | xargs git branch -D ; deletes all local branches not named main or develop or currently checked out
::,,nv::--no-verify


; serverless stuff
::,,sdd::sls deploy --stage=danny
::,,sid::sls info --stage=danny
::,,srd::sls remove --stage=danny


; feedback stuff
::,,dust::[[dust]](https://www.netlify.com/blog/2020/03/05/feedback-ladders-how-we-encode-code-reviews-at-netlify/)
::,,sand::[[sand]](https://www.netlify.com/blog/2020/03/05/feedback-ladders-how-we-encode-code-reviews-at-netlify/)
::,,pebble::[[pebble]](https://www.netlify.com/blog/2020/03/05/feedback-ladders-how-we-encode-code-reviews-at-netlify/)
::,,boulder::[[boulder]](https://www.netlify.com/blog/2020/03/05/feedback-ladders-how-we-encode-code-reviews-at-netlify/)
::,,mountain::[[mountain]](https://www.netlify.com/blog/2020/03/05/feedback-ladders-how-we-encode-code-reviews-at-netlify/)


; Control + Shift + C will automatically search Google for the copied text
^+c::
{
  Send, ^c
  Sleep 50
  Run, https://www.google.com/search?q=%clipboard%
  Return
}

; Control + Shift + Z toggles Windows terminal
SwitchToWindowsTerminal()
{
  windowHandleId := WinExist("ahk_exe WindowsTerminal.exe")
  windowExistsAlready := windowHandleId > 0

  ; If the Windows Terminal is already open, determine if we should put it in focus or minimize it.
  if (windowExistsAlready = true)
  {
    activeWindowHandleId := WinExist("A")
    windowIsAlreadyActive := activeWindowHandleId == windowHandleId

    if (windowIsAlreadyActive)
    {
      ; Minimize the window.
      WinMinimize, "ahk_id %windowHandleId%"
    }
    else
    {
      ; Put the window in focus.
      WinActivate, "ahk_id %windowHandleId%"
      WinShow, "ahk_id %windowHandleId%"
    }
  }
  ; Else it's not already open, so launch it.
  else
  {
    Run, wt
  }
}
^+z::SwitchToWindowsTerminal()


; Control + Shift + X toggles Visual Studio Code
^+x::
  SwitchToVSCode()sett
return

SwitchToVSCode() {
  exeName := "Code.exe"
  windowHandleId := WinExist("ahk_exe " exeName)
  windowExistsAlready := windowHandleId > 0

  if (windowExistsAlready = true) {
    activeWindowHandleId := WinExist("A")
    windowIsAlreadyActive := activeWindowHandleId == windowHandleId

    if (windowIsAlreadyActive) {
      WinMinimize, "ahk_id %windowHandleId%"
    }
    else {
      WinActivate, "ahk_id %windowHandleId%"
      WinShow, "ahk_id %windowHandleId%"
    }
  }
  else {
    Run, % exeName
  }
}
