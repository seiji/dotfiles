var PLUGIN_INFO =
<VimperatorPlugin>
<name>{NAME}</name>
<description>general search</description>
<description lang="ja">CPAN モジュールを検索し、補完します。</description>
<minVersion>2.0pre</minVersion>
<maxVersion>2.0pre</maxVersion>
<updateURL></updateURL>
<author mail="seijit@me.com" homepage="http://seiji.me">Seiji Toyama</author>
<license>MPL 1.1/GPL 2.0/LGPL 2.1</license>
<version>0.1</version>
<detail><![CDATA[
:cpan[!] Moo::Me[tab]:
   openが単に面倒臭い。
]]></detail>
</VimperatorPlugin>;

(function() {
var p = function(arg) {
    Application.console.log(arg);
    // liberator.log(arg);
};

commands.addUserCommand(
    ['g'],
    'Google Search',
    function(args) {
        var name = (args.string || '').replace(/^\^|\s+/g, '');
        var url = 'http://www.google.co.jp/search?q=' + name;
        liberator.open(url, liberator.NEW_TAB);
    },
    {},
    true
);

})();

