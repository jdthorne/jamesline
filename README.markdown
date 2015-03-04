Jamesline
=========

It's basically a super-lightweight version of [Powerline](http://github.com/lokaltog/powerline) that displays your current folder relative to either your home folder, or the nearest .git repository root.

Ever get frustrated at having your terminal prompt look like this?

    ~/Work/Contracting/Projects/Active/The Project/workspace/src/module/folder $

Well, now it can look like:

    Project ❯ Module ❯ Folder ❯

instead.

And even better, Jamesline lets you know when you're SSHed into your machine too:

    james@Hostnae ❯ / ❯ etc ❯


Installation
------------

Clone the repo somewhere, then put the following in your .bash_profile:

    function _update_ps1()
    {
        export PS1="$(/path/to/jamesline/jamesline.sh)"
    }

    export PROMPT_COMMAND="_update_ps1"
