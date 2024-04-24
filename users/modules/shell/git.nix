#
# Git configuration
#

{
  programs = {
    git = {
      enable = true;
      userName = "Mark Wood";
      userEmail = "mark@markandkc.net";
      aliases = {
        amend = "commit --amend --no-edit";
        update = "commit --amend -m";
      };
    };
  };
}
