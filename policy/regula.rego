package fugue.regula.config

__rule_id(pkg) = ret {
  metadoc = object.get(data.rules[pkg], "__rego__metadoc__", {})
  ret = object.get(metadoc, "id", null)
}

__contains_name_or_id(s, pkg) {
    s[pkg]
}

__contains_name_or_id(s, pkg) {
    i = __rule_id(pkg)
    s[i]
}

__excludes := {"FG_R00436","FG_R00385","FG_R00404","FG_R00405","FG_R00406","FG_R00409","FG_R00433","FG_R00383"}

rules[rule] {
    data.rules[pkg]
    __contains_name_or_id(__excludes, pkg)
    rule := {
        "rule_name": pkg,
        "status": "DISABLED"
    }
}