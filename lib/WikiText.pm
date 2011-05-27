##
# name:      WikiText
# abstract:  Wiki Text Conversion Tools
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2008, 2011

package WikiText;
use 5.008003;
use strict;
use warnings;

our $VERSION = '0.11';

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    $self->{wikitext} = shift;
    return $self;
}

sub to_html {
    my $self = shift;
    my $parser_class = ref($self) . '::Parser';
    eval "require $parser_class; 1"
      or die "Can't load $parser_class:\n$@";
    require WikiText::HTML::Emitter;
    my $parser = $parser_class->new(
        receiver => WikiText::HTML::Emitter->new,
    );

    return $parser->parse($self->{wikitext});
}

1;

=head1 SYNOPSIS

    use WikiText::Sample::Parser;
    use WikiText::HTML::Emitter;
    
    my $parser = WikiText::Sample::Parser->new(
        receiver => WikiText::HTML::Emitter->new,
    );
    
    my $wikitext = "== A Title

    This is some text that contains a '''bold phrase''' in it.
    ";
    
    my $html = $parser->parse($wikitext);

=head1 DESCRIPTION

The WikiText modules parse documents in various formats. A parse has a
receiver. The receiver takes the parse events and creates a new form. The new
form can be HTML, an AST or another wiki markup.

Some formats are richer than others. The module WikiText::WikiByte defines a
bytecode format. The bytecode format is rich enough to be a receiver for any
parse, therefore it makes an ideal intermediate format.
