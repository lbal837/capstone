function mySettings(props) {
    return (
        <Page>
            <Section
                title={<Text bold align="center">Fitbit Account</Text>}>
                <Oauth
                    settingsKey="oauth"
                    title="Login"
                    label="Fitbit"
                    status="Login"
                    authorizeUrl="https://www.fitbit.com/oauth2/authorize"
                    requestTokenUrl="https://api.fitbit.com/oauth2/token"
                    clientId="23QVYW"
                    clientSecret="f717d81ba2d273c1f0c37650d0a90659"
                    scope="sleep"
                />
            </Section>
        </Page>
    );
}

registerSettingsPage(mySettings);