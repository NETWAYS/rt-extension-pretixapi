package RT::Condition::Pretix;
use base 'RT::Condition';

use strict;
use warnings;

=head2 IsApplicable

=cut

sub IsApplicable {
    my $self = shift;

    my $REGEX = RT->Config->Get('PretixSender_Regexp') // '';
    unless ($REGEX) {
        RT->Logger->error('Pretix: $PretixSender_Regexp not set!');
        die('Pretix: $PretixSender_Regexp not set!');
    }

    foreach my $email ($self->TicketObj->Requestors->MemberEmailAddresses) {
        if ($email =~ m/$REGEX/) {
            RT->Logger->info('Pretix: ' . $email . ' is Pretix sender, condition is applicable');
            return (1);
        }
    }

    return (0);
}

RT::Base->_ImportOverlays();

1;

