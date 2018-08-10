/* iptables module to match on related connections */
/*
 * (C) 2001 Martin Josefsson <gandalf@wlug.westbo.se>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
#include <linux/module.h>
#include <linux/skbuff.h>
#include <linux/netfilter.h>
#include <linux/netfilter/x_tables.h>
#include <uapi/linux/ip.h>
#include <linux/ip.h>

MODULE_LICENSE("GPL");
MODULE_ALIAS("ipt_coscup");
MODULE_ALIAS("ip6t_coscup");

struct xt_coscup_info {
        char message[30];
};

static bool
coscup_mt(const struct sk_buff *skb, struct xt_action_param *par)
{
        const struct xt_coscup_info *coscupInfo = par->matchinfo;
        struct iphdr *ip_header = ip_hdr(skb);

        unsigned int src_ip = (unsigned int)ip_header->saddr;
        unsigned int dest_ip = (unsigned int)ip_header->daddr;

        printk(KERN_DEBUG "IP addres = %pI4  DEST = %pI4, message[ %s ]\n", &src_ip, &dest_ip, coscupInfo->message);
	return true;
}

static int coscup_mt_check(const struct xt_mtchk_param *par)
{
	return 0;
}

static void coscup_mt_destroy(const struct xt_mtdtor_param *par)
{
}

static struct xt_match coscup_mt_reg __read_mostly = {
	.name       = "coscup",
	.revision   = 0,
	.family     = NFPROTO_UNSPEC,
	.checkentry = coscup_mt_check,
	.match      = coscup_mt,
	.destroy    = coscup_mt_destroy,
	.matchsize  = sizeof(struct xt_coscup_info),
	.me         = THIS_MODULE,
};

static int __init coscup_mt_init(void)
{
	return xt_register_match(&coscup_mt_reg);
}

static void __exit coscup_mt_exit(void)
{
	xt_unregister_match(&coscup_mt_reg);
}

module_init(coscup_mt_init);
module_exit(coscup_mt_exit);
