function MyResultFunction()
{

    #EVEY CONSOLE OUTPUT IS PIPED TO $NULL
    $Null = @(

        $res = New-Object Base.Result("Starting module X...")

        #HERE YOUR FUNCTION CONTENT


    )

    #return , $res: Comma is important character. Do not delete.
    return , $res

}


[Base.Result]$res = MyResultFunction

$res.Dump()